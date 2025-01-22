Return-Path: <linux-arch+bounces-9857-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A342A19AFA
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 23:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F543AB807
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 22:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6EC1CAA66;
	Wed, 22 Jan 2025 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yzNGaW+r"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B731C4A06
	for <linux-arch@vger.kernel.org>; Wed, 22 Jan 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585471; cv=none; b=kL1JSef8XeeNz4C4842UVTfSDRQjwWVFvkPomyWBRLClNjNmPh9m/iHfVAzBbQ1aTh0YfsoiFMlG3GqAQCInJv1MujYohn4GVwtLLa/kYbIYQwoxUEn4f7DCvcUbjzAgyG46pikrQvDDF73SujF2SDuNwjoiHLMg1QrXY0ifbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585471; c=relaxed/simple;
	bh=muQHKH+YtVhs47z/cQO4qQSWMU8f3qzDbgNESrFc+dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTkHWn9MvybQoLtwIwMgLClOCtk3/MuiIyZiwCapC3iKqa0+/BM+PsALSx/yAwe+11N62jqJV396DDf0v9Is/F+XMAf5ppQNS7CyXV+GvrMkSiPep437NWfJHzfwTj5ErVn6A8pX8ChITA100SlDIuHw8aaVbiKvaokBDY1bOZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yzNGaW+r; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4678c9310afso31021cf.1
        for <linux-arch@vger.kernel.org>; Wed, 22 Jan 2025 14:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737585468; x=1738190268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNWPmlwGRos1SZFW6JfxWy7NUgqHSwSZwtnxl8s4MEk=;
        b=yzNGaW+rpJVvIbL1uRP3WSqtnQ1JUMb/2vRhMvJW3uJqo6bv60EuV+KeeQQ/4uyPmz
         csNVSpZ34J+gLB64h6TSv3kyaXBxZNpaDPyR6J6+uBxaQarV9VGITRdbfbpnJ2ckA053
         y/IGlODEZX3S4HxoWHw5ih7ehKfWlm3KLaFREIu1RpfElUvdAASnYgzmwMi4o94Ililc
         Wdcb0fYq2JA4DOBMxY3n6tU4a7QoyOk9fWZrU41c1wt5qM5Vq5AMAgGiFLQU1r4khn3a
         2XBZGKKe40r6rKiJ13rOca0mcXUJZOCB6FYElrA3yc1IrvugDB9qQCG0qZx56FvJ8enM
         RQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737585468; x=1738190268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNWPmlwGRos1SZFW6JfxWy7NUgqHSwSZwtnxl8s4MEk=;
        b=FRmleMyCau0xjSWDSARFIKR8TLKvGZtGJnCfIuaDQgIw7p+GScwpjGHE92GA89aOle
         BUsBOBpDSKTrn+zW8bGuyrhFbAttMHAspwL9xMXO9lJXN1IEVt+NjZshW5+b/qi8h0Wr
         QVuRwMt46Bp7g9ayxwlDUNckdkL3gOaCPnIXffVUeTYd62KcW8rfH1DN5sTArlReY9Zh
         MNANQVCdh6BkasEnZY3Kn7/AJfrECcF/77Hq2YseJtw1UFgUbZT8IpsgHVILwhJJS0id
         fFD65THMywhJidIUPqaKZAdhDNvllvQVLgwvVktntXdLuPZnV9jpf+Zf6AWONCDUMko/
         z+FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKgr6DO8oGEMwoovFoOtaaX4vAN3dPxjMKt+3ERNOXUwUUWjn61elTO3WQxAqgjKsmFtFS9hTkvmdK@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZRfkCTkXMCT+yqAvplovCAdTh4BqavcsXiVCQVYXYdWSwQP5
	sIRKipKTBJfipzMPy/ZW32LcHUxsU7O65NBCmBwpXI/H0gh4EqjeeNjq3oiJA7JkbQ+Ed68Rg4w
	ZQBsCJ/d3SKW+to9Daaxil3wnx1CGujqCpplW
X-Gm-Gg: ASbGnct8439cOfSX9671Q3CqNa8HSiW156daKuuOItvcZPv+jLKOWKTnjT5S8IYBhzU
	LtnePc+GQejRUW9BlrobheXVzsl74B1cF54IPkdFfUPU5IcTaoS1jlvWklUGbhMf+x6Yw8GyrNi
	8o9QI=
X-Google-Smtp-Source: AGHT+IE7sdb1UO7lPrISBGAhpx5JEvuTlWU+6OO+ygvNWlmkeAdywMg6ssKZ6NWKbxANm+Cry9tUm/RyIi756qhPSFI=
X-Received: by 2002:a05:622a:1b8e:b0:46c:791f:bf2f with SMTP id
 d75a77b69052e-46e5da99a74mr280031cf.1.1737585468033; Wed, 22 Jan 2025
 14:37:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120212839.1675696-1-arnd@kernel.org> <CAF1bQ=QFxE8AvnpOeSjSeL1buxDDACKVNufLjw99cQir0pyS_Q@mail.gmail.com>
 <c5855908-df1f-46be-a8cf-aba066b52585@app.fastmail.com> <CAF1bQ=SEybO_+UMDqspA+9OecYqJhE56D-zJyxEUiPcj+Af_fA@mail.gmail.com>
 <04db1d00-8801-4d29-bed9-54b2cc39e4fc@app.fastmail.com>
In-Reply-To: <04db1d00-8801-4d29-bed9-54b2cc39e4fc@app.fastmail.com>
From: Rong Xu <xur@google.com>
Date: Wed, 22 Jan 2025 14:37:36 -0800
X-Gm-Features: AWEUYZm3KSmYxfUanGEFArAdq_FoZxyzTMm-E5VEa9MroDn3oTe2JaMTTo7tTxs
Message-ID: <CAF1bQ=Q+FLu=RYT5tVT0Nrre72w-_sgXMw=sr0MBXhgudbJn4w@mail.gmail.com>
Subject: Re: [PATCH] [RFC, DO NOT APPLY] vmlinux.lds: revert link speed regression
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-kbuild@vger.kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, Han Shen <shenhan@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 12:30=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Wed, Jan 22, 2025, at 19:47, Rong Xu wrote:
> > On Tue, Jan 21, 2025 at 1:18=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >>
> >> On Tue, Jan 21, 2025, at 18:45, Rong Xu wrote:
> >> > On Mon, Jan 20, 2025 at 1:29=E2=80=AFPM Arnd Bergmann <arnd@kernel.o=
rg> wrote:
> >> >
> >> > Yes. The order could be conditional. As a matter of fact, the first
> >> > version was conditional.
> >> > I changed it based on the reviewer comments to reduce conditions for
> >> > more maintainable code.
> >> > I would like to work from the ld.bfd side to see if we can fix the p=
roblem.
> >>
> >> Makes sense. At least once we understand what makes the linker so slow
> >> and fix future versions, it should also be possible to come up with
> >> a more effective workaround for the existing linkers that suffer from =
it.
> >
> > @Arnd: Can you send me the instructions to reproduce this regression?
>
> My report had linked to the config that I saw originally:
>
> >> > Link: https://pastebin.com/raw/sWpbkapL (config)
>
> This is for a x86_64 build, and I used 'make savedefconfig' to
> simplify it, so you have to copy it to arch/x86/configs/test_defconfig
> and run 'make test_defconfig' to get the full file back.
>
> I have also uploaded a reproducer to
> https://drive.google.com/file/d/14xWdD_S51XBgV6kOajLvdtOef7tQTZQq/view?us=
p=3Dsharing
> but it's fairly large. The reproducer is from ld.lld --reproduce=3D, but
> you can simply unpack it and do
>
> x86_64-linux-gnu-ld.bfd  -m elf_x86_64 -z noexecstack --emit-relocs --dis=
card-none -z max-page-size=3D0x200000 --gc-sections --build-id=3Dsha1 --orp=
han-handling warn --script home/arnd/arm-soc/build/x86/0xA8B23FFD_defconfig=
/arch/x86/kernel/vmlinux.lds --strip-debug -o .tmp_vmlinux1 --whole-archive=
 home/arnd/arm-soc/build/x86/0xA8B23FFD_defconfig/vmlinux.a home/arnd/arm-s=
oc/build/x86/0xA8B23FFD_defconfig/init/version-timestamp.o --no-whole-archi=
ve --start-group home/arnd/arm-soc/build/x86/0xA8B23FFD_defconfig/lib/lib.a=
 home/arnd/arm-soc/build/x86/0xA8B23FFD_defconfig/arch/x86/lib/lib.a --end-=
group home/arnd/arm-soc/build/x86/0xA8B23FFD_defconfig/.tmp_vmlinux0.kallsy=
ms.o
>
>     Arnd

Thanks Arnd. I can reproduce the issue with your files.

The slowdown was caused by the following change in elflink.c:

commit fba1ac87dcb76e61f270d236f1e7c8aaec80f9c4
Author: Tomoaki Kawada <kawada@kmckk.co.jp>
Date:   Thu Jun 16 09:54:30 2022 +0000

    Fix the sorting algorithm for reloc entries

    The optimized insertion sort algorithm in `elf_link_adjust_relocs`
    incorrectly assembled "runs" from unsorted entries and inserted them to=
 an
    already-sorted prefix, breaking the loop invariants of insertion sort.
    This commit updates the run assembly loop to break upon encountering a
    non-monotonic change in the sort key.

I haven't looked closely into this. The fix is most likely valid. But
the code might not be efficient.

-Rong

