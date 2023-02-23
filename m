Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE6B6A055E
	for <lists+linux-arch@lfdr.de>; Thu, 23 Feb 2023 10:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjBWJyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Feb 2023 04:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjBWJyl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2023 04:54:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055C44D63B
        for <linux-arch@vger.kernel.org>; Thu, 23 Feb 2023 01:54:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so5802241wmq.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Feb 2023 01:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mAI7GZiBb7iDC4DRNXr8MXcTGzYlBwIWTXO3a37K9fA=;
        b=6rqEsmJobKimBOx+ObGs4Y9oYCoGGA+7PUJSCUc+XzhAJr7k8trhGNeL9l///zHG9h
         zKi4GFdApLZMJxwwGKyAK5T4vZVP0aQ3XXyt/OWPp5oueU3BzBJzSR5QoLC+/Xx2iJgz
         5hm79+32XzmlSgEMuCRgCF6jE20gfyjKVSWE2hFVc6aKlMZQREWTRqXyzaVmSBj/MhzH
         AXlVDuu21E6Hjr/kwbOkk278Lu43ZitZTQ7OHZU1h8q5OpD5tJY9ufRMnPPJf2Rq79nz
         v4bZ2eQSQps7BpX5yAyoX5mS+40xRdAoLwhab6GQ6F1yPaND58wp3xipYKvUJEcT++Q8
         E7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAI7GZiBb7iDC4DRNXr8MXcTGzYlBwIWTXO3a37K9fA=;
        b=HrbljN6qjrizPtKoApcl79vAQ+tTbJb1wgeLjAQAQyK6oKHKGSxG54djxNGiape7p4
         ATXkz2Sf2keBfrpVAN3dTc40134JEvEnn+he74GJwg2waEGe9R/W1g1dWSod+9NMHpH2
         +1XTy0ogVOE4iBHvGdrLr5x3s3i8e8+rfhBE+EBy74IDofSeCRyZr+cfXAgKe1/4L1E1
         MkTC1xgRKG550PAihAPCmkWaf1ikV93DDon8B5t+rR2k0HKdazUrR6x9fhnyyIqXPyKA
         3KwNeA1la57sMya/aA04mGcynKib9lZKxoHo/GRPw0athKw5//KecuqM70RmVrFSzcPb
         VyhA==
X-Gm-Message-State: AO0yUKXyv77WW94sIYrLMiuz+8AzLzoqszxklNReCEJoUV/ByKW+9wLr
        QA1VtboVkpXzLwpIbJ/eTWNIdlxBvg6zxAc4YoAQDA==
X-Google-Smtp-Source: AK7set+bh83ESZvs/5JP0HBfjTnQ76DE1v1RkcKyYbYV7gCfY3t7LNoC9ir4Jaga+QNOEzC6TCzSn38PMw2DLd3UjM4=
X-Received: by 2002:a05:600c:3b9c:b0:3df:df03:45be with SMTP id
 n28-20020a05600c3b9c00b003dfdf0345bemr826148wms.7.1677146076791; Thu, 23 Feb
 2023 01:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20230214074925.228106-1-alexghiti@rivosinc.com>
 <20230214074925.228106-4-alexghiti@rivosinc.com> <Y+zXIgwO5wteLQZ5@shell.armlinux.org.uk>
 <f3e1585c-0d9d-4709-9b21-74a63d8cc9ac@app.fastmail.com>
In-Reply-To: <f3e1585c-0d9d-4709-9b21-74a63d8cc9ac@app.fastmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 23 Feb 2023 10:54:26 +0100
Message-ID: <CAHVXubgsvjxGbgM6AcxfsHDsHT0iL2pAemGMr5t8KVLKiqC3RA@mail.gmail.com>
Subject: Re: [PATCH v3 03/24] arm: Remove COMMAND_LINE_SIZE from uapi
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Wed, Feb 15, 2023 at 2:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 15, 2023, at 13:59, Russell King (Oracle) wrote:
> > On Tue, Feb 14, 2023 at 08:49:04AM +0100, Alexandre Ghiti wrote:
> >> From: Palmer Dabbelt <palmer@rivosinc.com>
> >>
> >> As far as I can tell this is not used by userspace and thus should not
> >> be part of the user-visible API.
> >>
> >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> >
> > Looks good to me. What's the merge plan for this?
>
> The easiest way is probably if I merge it through the whole
> series through the asm-generic tree. The timing is a bit
> unfortunate as we're just ahead of the merge window, so unless
> we really need this in 6.3, I'd suggest that Alexandre resend
> the series to me in two weeks with the Acks added in and I'll
> pick it up for 6.4.

Sorry for the response delay, I was waiting to see if Palmer would
merge my KASAN patchset in 6.3 (which he does): I have to admit that
fixing the command line size + the KASAN patchset would allow 6.3 to
run on syzkaller, which would be nice.

If I don't see this merged in 6.3, I'll send another round as you
suggested in 1 week now :)

Thanks!

Alex

>
>      Arnd
