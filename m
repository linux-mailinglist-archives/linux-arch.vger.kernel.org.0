Return-Path: <linux-arch+bounces-12281-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AADAD11B3
	for <lists+linux-arch@lfdr.de>; Sun,  8 Jun 2025 11:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE5987A584C
	for <lists+linux-arch@lfdr.de>; Sun,  8 Jun 2025 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85618201266;
	Sun,  8 Jun 2025 09:40:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388113C3CD;
	Sun,  8 Jun 2025 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749375607; cv=none; b=DBrOrxa7fqAtxq7Z3mc+uoNrk8AjRx/6dPxakKQAmh2AhTDbATCLtuNvP1AoIWKC2XEUPtQ/iMyyYq/PCy27cPV0zZnCFAlQgy0UqYClLegqGn1o4Dvh0rLnDk3M04nwd/bqMEcCfLgYgT8v3mcD6CfDPOzCShRu6i1+mChiPsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749375607; c=relaxed/simple;
	bh=jmOKtbWnlZR/Qj4SRxgpy6Bosb3xk2ulOZQUv/2xbV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tW74rKP6k0eQ28uD7L2ybq00w+8JTrkubZz8mBTg3CrpYpAde936FVg3gr0srbX1M65G9CrrjkAaqCnojOXa5fKip2j0m7zerFSKBqwLusGF5BQOmb0nCg7yv7o04u6EUiZMp91OkZuWjPBeaQlLw+SRwnhjIAQTRKqTzpjnExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86dc3482b3dso3311611241.0;
        Sun, 08 Jun 2025 02:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749375603; x=1749980403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEIWuLmQRMVnfGdgxWwMM+uZrcmSfOPwu48WTLXFYZc=;
        b=FQ49nG+NYCapJSfIWvAlwycy5ndpx8FFnqNTWgzo7CHVdoBVq5deGBhww95xtAfz5I
         cFy9n/6uTiS8r/KkBg4nr2d8atJwMPLJXILtNEjlohS/Dh45SahKjGzjev0eLsO72NQp
         e8HDZArYL7UNIJbfiEq5tQ4sOm6zfz6se1N81ibS6R8gITeFDq5ZjH/RA5ANDTt4IIL8
         DIp4yJUADtVxCdvB4ZpEtD9bkxg8nbHy4eJmReZ2fOvVCkZeKgTh3/zkgpjW1sNkjd9o
         oRt6m4NolOPXwguJ5iFU2qqDosQcgujCVZq/+4NYNeafIPPA9/dGcjjwdx2wE5EbhZt9
         +8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUUOrQloc06UMSGIq7chphkSKUhmI9SVQpJEpqDTAeSX+O4dsVT7i38OsVFQDWDjaQ0HgrM9uapzkXnFg==@vger.kernel.org, AJvYcCUu63wOKaRIWLcYnFoCpr30beyPjEimyQku0bxy8sln/BZRzQdQd2JS6XBmTE7uudcPARf6SWNyfV0v9q9W@vger.kernel.org, AJvYcCVprdXgysrju6r2gTUV5GhSwRZPLTWsMhmx4bduAUex97sgJ+uOb2yCSpAx/zO65ebimisvW8CDAP6yLw==@vger.kernel.org, AJvYcCWur67BUROTjybMFyCZS3KSc/VZFPMgRpAR4xLfDP+2lkoTs+RMYuiqIdgkov9q8ls+5cgZ7PHzlmJSVA==@vger.kernel.org, AJvYcCX2dIXMCy9rzUM0k3Znvdf6VzHpWfYGMdtUyYKVSXsmnW7jBiZZG61GdnkLHJM+1vCzYP+jBmwRocL0QeV1@vger.kernel.org, AJvYcCXfuqrLSswtlqw4o3PVUyNSQ9mrFK8DBir+dECR6V7oYrwLeZRuSCJtUp8UNRBKcjPWN1V6lh7hxy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqccnZyyOeQ61Wm5ZQ/CA/5PdxHQ26FKRWu5B9MmguRKZlTEAA
	qlOOm9WnY57efFNq1YjOilRssOfKfroQ5gyZxX20G4xBXixySZLDmeQAOqs257cZ
X-Gm-Gg: ASbGncvi2+dI8D4GyaS5XklLUVJCX6KeByi8gLTbGMeFf+LoH+ergHuWgLFahwcNxZ+
	Pk3Yws0Mz8PFZdzmhgm6itZxKbZJrMp3pa9eS6eRXH1ZEoMStMEfvTs2mRQI/cEar9js83dG4UW
	qhhCn2TLDRW6gSiQ3IAxEYf67j7vjK7QqC0A/3/NxlsC+KjFOL4PP02XIz69Pjx4JbvdoUTxSWa
	kdDYqhG7Hc3a9GMMsp3wozRQP3fwvCK0VpNF8RgZ21cbpr2yHj+yFZalZ3g1NHrCg3XLcz/+oLW
	9q6m+I4dwzojCTLEWkUNO14PKflKF+I/g7v1joWLIzOAep0J4DGi8dqoEWP9W+MKYlv9r87Cdlz
	tfdqmtKQoKAFLYQ==
X-Google-Smtp-Source: AGHT+IFFRTsX4zji27GtOQhqbjypLPDgS4HW3J/n9oo3bfkpmbOXIglvGmWqTvAwWqyWO3L9/nYU4A==
X-Received: by 2002:a05:6102:3c0a:b0:4df:9aed:3114 with SMTP id ada2fe7eead31-4e78415022bmr2156237137.8.1749375603104;
        Sun, 08 Jun 2025 02:40:03 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ece19b65esm1223526241.9.2025.06.08.02.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 02:40:01 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87ded9c6eb4so2331121241.0;
        Sun, 08 Jun 2025 02:40:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDUHBe8RWAKmGC23fYLFGcpZ+MOaRQx/0CgJ4xe0Hx03wEEVtkV4qB1zzjI0ZY+RcSAi4yGyNXVyNLUrvq@vger.kernel.org, AJvYcCVo2USSKofPQYPuy8hqjLozBCUtG5H+MFHcS2EHIWMGltSLqm5QbI9oQ+yEMgw/dSu1/Mg5b5Ocuwp3OA==@vger.kernel.org, AJvYcCW7mN/xMiI0FoL7GJqkPqlUUe/Sik/jbe6e6qFbX44zCVebWK5WxAeoR7+VQnbziRq3g3iakBvy2H2CKA==@vger.kernel.org, AJvYcCWTLZAGY7NB/FrSHIXe44cbuZTBhehwkInX+Ne2AED1V9hUxpp7tHkckQ2DtcSao6jVEcfSdZfYKE8YIg==@vger.kernel.org, AJvYcCWeoAymX/z6XHoJimghcF/0F7XHnP2fJTfvW0i0NtKSKMo03fR2jejbyl2L5E0u4G1rP3i45mx3uBQ=@vger.kernel.org, AJvYcCX5wIg2XHgA2s25ryc4EwEl7K4lNCnJtJkR3kxZJM5mriUMPSxLWtVX17OIA5htrBZAsNsRXu6TV4OrpNIt@vger.kernel.org
X-Received: by 2002:a05:6102:12c7:b0:4e1:ec70:536 with SMTP id
 ada2fe7eead31-4e784052d39mr1902461137.4.1749375601424; Sun, 08 Jun 2025
 02:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315105907.1275012-1-arnd@kernel.org> <20250315105907.1275012-3-arnd@kernel.org>
 <6c7770dd1c216410fcff3bf0758a45d5afcb5444.camel@physik.fu-berlin.de>
In-Reply-To: <6c7770dd1c216410fcff3bf0758a45d5afcb5444.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 8 Jun 2025 11:39:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXeTWSU64jQt+nybsSBOpBEu_zO0WmE5FK1PnA3YkALUQ@mail.gmail.com>
X-Gm-Features: AX0GCFt4vabIohtnnm_mFUKWYT8sgcrvXqd5vSNi-se7k7UhxzRe5PjaG9sA3nI
Message-ID: <CAMuHMdXeTWSU64jQt+nybsSBOpBEu_zO0WmE5FK1PnA3YkALUQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] sh: remove duplicate ioread/iowrite helpers
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Julian Vetter <julian@outer-limits.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Adrian,

On Sat, 7 Jun 2025 at 14:08, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Sat, 2025-03-15 at 11:59 +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The ioread/iowrite functions on sh only do memory mapped I/O like the
> > generic verion, and never map onto non-MMIO inb/outb variants, so they
> > just add complexity. In particular, the use of asm-generic/iomap.h
> > ties the declaration to the x86 implementation.
> >
> > Remove the custom versions and use the architecture-independent fallback
> > code instead. Some of the calling conventions on sh are different here,
> > so fix that by adding 'volatile' keywords where required by the generic
> > implementation and change the cpg clock driver to no longer depend on
> > the interesting choice of return types for ioread8/ioread16/ioread32.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>

> Those are quite a number of changes that I would like to test on real hardware
> first before merging them into the kernel.
>
> @Geert: Could you test it on your SH-7751 LANDISK board as well?

Already done for a while, as this patch is commit 2494fce26e434071 ("sh:
remove duplicate ioread/iowrite helpers") in v6.15-rc1 ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

