Return-Path: <linux-arch+bounces-5931-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23859945D6B
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 13:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86417B2105D
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 11:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054001DB44E;
	Fri,  2 Aug 2024 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8OHikux"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831C1E877;
	Fri,  2 Aug 2024 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599540; cv=none; b=qJ//gE7gwg6/mn5TaG2XfzhpsJYOoA0GJcrIgRbFdnHZpiEAAPHY8UEn0sV7Qerm/eOR6318VqAyR1yIiWnJxOrqrMoP7Jnh9ZRtqsJik2vgoAz8EWm94YQy44uvtfsMYWYN2k3Abj9nDYmbaiTEcfnfjp/N4U1XWuPveslhx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599540; c=relaxed/simple;
	bh=oDTT9xD0J08N7Yb3Af6JPWNNvQszF2stgvrDAhrhfNs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKjosMjKLr9DLcRrb7/Vc6FneSPTdmgg0L37w1sgQjZUA9dom25IBKUaHLT0yHxH/KZdeFE7c9FHSfheciQb2NfITHzZ7v8FHzoO+E9CFH+2XdIA+bYzBDKOOJxTUZxpDKv8nmm1nOhcWkcoD0lTaTXzCsedxekDzkOA6m7iNpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8OHikux; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso8541894a12.0;
        Fri, 02 Aug 2024 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722599537; x=1723204337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=46L6nTfwlpEOKrJbpXIYVmIVoshBQpihOVyTwQcqTFE=;
        b=H8OHikuxVOXEa2KdX7+r5MdgTERQKDBwCCktu33zql3HrI6sZDkvLTZfHe7iUne8Ba
         Jubpa9FFDGQynKIwgawMA/na6cFrLsAmlFwy7Zz2QEqHIHfOy2x3AOQBymmMI7501ukc
         ljoDqUKN8S4L2iBJO5LBVV70OMaTxR8gyDC8tAT/SFOw9HKPYVcfGyfC3d7LrffsVBLr
         lv48OOw5S9WWVLlD7Vh7yo57lAivqEU5KwbaaHyftz0HzpaDINfOhoUylDR2C9hdAPoQ
         t6p8sxBXRIfaP6W5SP7U60QTor4pRu56nxppH8WSW5B/QPeW89LHFXl6wS7fvBT0dfvH
         HYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722599537; x=1723204337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46L6nTfwlpEOKrJbpXIYVmIVoshBQpihOVyTwQcqTFE=;
        b=e4x5rv1vBdQoXZOq3ExFLdfAAejIJk2dZw4oJT1sj5I1ys05kBq1knCId6OQp0qLSu
         vffjrxTQSgy5teBLhcCoxpQy+rgTscs2FkShHXdiEzxPNrYyUmjeg/Z81+7ZREikIldW
         UVw1ez47NppmdknAn70Bhtpy21EX+xRfhxVV3+W31DEwOZTcy2zmknUwmiPWSgrUffGa
         1xsXcwi1Za4sSkxuc03AoapWTNHAdx8VbWAgJ6uhbTxFE/kWi3oVGeuRn47IU0EJPHok
         I+PAxzvpGuePVhFAwDy1iq6S3Wc7eZND518g3aZuRCpP0jyqu7rAoUezDPMJz2xs/G3p
         574g==
X-Forwarded-Encrypted: i=1; AJvYcCVEVZKau2XfD70REDq86FQvLCqv3qxWcUgCBS+okgcNE6Zpgq459PJrvT5XftDG9p3SLnG8YWrfCt9g+eNRsK+Q9wQMwelcJzwahqwJgaHigoRR7f4OQ3xHpm1NxNT0pIacT9zRYh1vCQ==
X-Gm-Message-State: AOJu0YxIYQEVrYxpgTvuyJGsaQYmUxI3dRjeoMCux1/HkptJaYZKNxid
	R7/aeGVQnjb+FCI/ZvyBczEp6hAEjIu0xYQiRrzMkYwzo/yoAwQq
X-Google-Smtp-Source: AGHT+IHufQNlGzmcrJffDFBWsb/bmgsJq/VLohwdwIe5kh6bRAB1LAYhwpPtXYIzKtv8V3TcSCECmA==
X-Received: by 2002:aa7:c406:0:b0:5a0:f0c4:aa7b with SMTP id 4fb4d7f45d1cf-5b7f5129461mr2068504a12.27.1722599536954;
        Fri, 02 Aug 2024 04:52:16 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839b2b0f0sm1009301a12.28.2024.08.02.04.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:52:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 2 Aug 2024 13:52:13 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [RFC] uretprobe: change syscall number, again
Message-ID: <ZqzIbU_T6sN01o5B@krava>
References: <20240730154500.3155437-1-arnd@kernel.org>
 <20240802181437.29b439e26608561f1289892a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802181437.29b439e26608561f1289892a@kernel.org>

On Fri, Aug 02, 2024 at 06:14:37PM +0900, Masami Hiramatsu wrote:
> On Tue, 30 Jul 2024 17:43:36 +0200
> Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Despite multiple attempts to get the syscall number assignment right
> > for the newly added uretprobe syscall, we ended up with a bit of a mess:
> > 
> >  - The number is defined as 467 based on the assumption that the
> >    xattrat family of syscalls would use 463 through 466, but those
> >    did not make it into 6.11.
> 
> OK... that was not expected.
> 
> > 
> >  - The include/uapi/asm-generic/unistd.h file still lists the number
> >    463, but the new scripts/syscall.tbl that was supposed to have the
> >    same data lists 467 instead as the number for arc, arm64, csky,
> >    hexagon, loongarch, nios2, openrisc and riscv. None of these
> >    architectures actually provide a uretprobe syscall.
> 
> Oops, thanks for finding.
> 
> > 
> >  - All the other architectures (powerpc, arm, mips, ...) don't list
> >    this syscall at all.
> 
> OK, so even if it is not supported on those, we need to put it as a
> placeholder.
> 
> > 
> > There are two ways to make it consistent again: either list it with
> > the same syscall number on all architectures, or only list it on x86
> > but not in scripts/syscall.tbl and asm-generic/unistd.h.
> > 
> > Based on the most recent discussion, it seems like we won't need it
> > anywhere else, so just remove the inconsistent assignment and instead
> > move the x86 number to the next available one in the architecture
> > specific range, which is 335.
> > 
> > Fixes: 5c28424e9a34 ("syscalls: Fix to add sys_uretprobe to syscall.tbl")
> > Fixes: 190fec72df4a ("uprobe: Wire up uretprobe system call")
> > Fixes: 63ded110979b ("uprobe: Change uretprobe syscall scope and number")
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > I think we should fix this as soon as possible. Please let me know if
> > you agree on this approach, or prefer one of the alternatives.
> 
> OK, I think it is good. But you missed to fix a selftest code which
> also needs to be updated.
> 
> Could you revert commit 3e301b431b91 ("selftests/bpf: Change uretprobe
>  syscall number in uprobe_syscall test") too?
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thank you,

yes, it still needs the selftest change like below
otherwise if that new number works for you then lgtm

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


---
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index bd8c75b620c2..5f78edca6540 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -216,7 +216,7 @@ static void test_uretprobe_regs_change(void)
 }
 
 #ifndef __NR_uretprobe
-#define __NR_uretprobe 467
+#define __NR_uretprobe 335
 #endif
 
 __naked unsigned long uretprobe_syscall_call_1(void)

