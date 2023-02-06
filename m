Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5E068BC68
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 13:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjBFMIh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 07:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBFMId (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 07:08:33 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46402278B;
        Mon,  6 Feb 2023 04:08:23 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id h24so12482826qtr.0;
        Mon, 06 Feb 2023 04:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02Ztaz85YCyWse0OOUudyylXWESo7R0bW8bc2JlaDZc=;
        b=6ACfGk4Cc6PZzFCtt8NUfiL++D4hT6IM6NhNOMgKyqM2gZ+DVEqw4/JdUtCVB3Tnkk
         4wVqFFVWn/6V8HrJmmcKDb6ZoG5rXSeNoL5nCxpluOCJOSa/i5eR0YS0z4/9cq/3HgCL
         6MhfWKflI3J00R4U/chAMiLamGLDUL4Go1/KBgc35FmQjTeovfaEtu4cbaVuRZw0X+dj
         TRm1ezciK9oIA+n5aolKHFhUbRM42AD9lUi3vRSRT9zhW//uk9e7lTysWoUiPwcJNaN6
         6uH22m2H0zNLagHNfWlCa+mDsmtpjf24Z9mCL62Xo5xRHcbczrFF+fLfiidTN2MzRbqN
         VFHw==
X-Gm-Message-State: AO0yUKWJpC6YMIBEOYY5yXJ5Lqpu97fWR/qML6CE5awgqg2hxmvl+pc2
        KVKHuEBZHhBnNMlCq565YNj3Eqm7h/D0XA==
X-Google-Smtp-Source: AK7set/llxk61OazyHQgc3fH/sHdW/g2/iwqMXVMVk+BhO6dxKFZxXZzA1vUeXUo2Uk6NGbpS4ro1g==
X-Received: by 2002:ac8:58d6:0:b0:3b9:b2ba:9b3d with SMTP id u22-20020ac858d6000000b003b9b2ba9b3dmr31701636qta.54.1675685302188;
        Mon, 06 Feb 2023 04:08:22 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 142-20020a370694000000b006fbb4b98a25sm7241573qkg.109.2023.02.06.04.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 04:08:21 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id o187so14136627ybg.3;
        Mon, 06 Feb 2023 04:08:21 -0800 (PST)
X-Received: by 2002:a25:e912:0:b0:8a0:2a4:a96c with SMTP id
 n18-20020a25e912000000b008a002a4a96cmr214639ybd.380.1675685301223; Mon, 06
 Feb 2023 04:08:21 -0800 (PST)
MIME-Version: 1.0
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9pD+TMP+/SyfeJm@FVFF77S0Q05N>
In-Reply-To: <Y9pD+TMP+/SyfeJm@FVFF77S0Q05N>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Feb 2023 13:08:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWtU=2Uq2QDu+eiBLve=uwJ4byU_1K2dKuUTH8wDUHoaw@mail.gmail.com>
Message-ID: <CAMuHMdWtU=2Uq2QDu+eiBLve=uwJ4byU_1K2dKuUTH8wDUHoaw@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mark,

On Wed, Feb 1, 2023 at 11:52 AM Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jan 31, 2023 at 08:02:51PM +0000, Al Viro wrote:
> > On x86 it had been noticed and fixed back in 2014, in 26178ec11ef3 "x86:
> > mm: consolidate VM_FAULT_RETRY handling".  Some of the other architectures
> > had it dealt with later - e.g. arm in 2017, the fix is 746a272e44141
> > "ARM: 8692/1: mm: abort uaccess retries upon fatal signal"; xtensa -
> > in 2021, the fix is 7b9acbb6aad4f "xtensa: fix uaccess-related livelock
> > in do_page_fault", etc.
> >
> > However, it never had been done on a bunch of architectures - the
> > current mainline still has that bug on alpha, hexagon, itanic, m68k,
> > microblaze, nios2, openrisc, parisc, riscv and sparc (both sparc32 and
> > sparc64).  Fixes are trivial, but I've no way to test them for most
> > of those architectures.
>
> FWIW, when I fixed arm and arm64 back in 2017, I did report the issue here with
> a test case (and again in 2021, with maintainers all explciitly Cc'd):
>
>   https://lore.kernel.org/lkml/20170822102527.GA14671@leverpostej/
>   https://lore.kernel.org/linux-arch/20210121123140.GD48431@C02TD0UTHF1T.local/
>
> ... so if anyone has access to those architectures, that test might be useful
> for verifying the fix.

Thanks a lot! This showed the problem on m68k, and confirmed Al's fix.

I'll give it a try on a few more systems later...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
