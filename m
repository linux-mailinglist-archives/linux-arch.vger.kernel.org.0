Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB0D73766A
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 23:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjFTVIh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 17:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFTVIg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 17:08:36 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0950810F4
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 14:08:35 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1aa291b3fc7so2368554fac.1
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687295314; x=1689887314;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmQQrNKBdrthlpawxC6xSdaVyb+Lurpl8t3TyJczrHw=;
        b=eu8qAVzcVZ8viHWEn7DJKQysOyHmyN3H358TpGlWOUq5rxusTRo5WvKJvwfkIAiC7e
         y8+IjksmtlSZE+llEeSTVW1JGeFoshOOW2tRaT17CmyyZw/HhqK5fvMGi2zQYoGhxnBz
         8qr/i9D+fjBbGnjTbB/WayODTELNKjEtRust9SgKeAryQdSeLh+RqIMFBZyeUgQmi28E
         P4Gf7tpI/jEUkm8uH4sGRiTycLmKS5QTRkMBK7NCFmvnRYkK/41BvGkKyv/CBAFAc7dY
         VU7klFXImiTY9qwJChlkdax0uD5zErezTXP3Ub7lCADlqhIDW3DVw8PFtZi3igb4B3sH
         kXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687295314; x=1689887314;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmQQrNKBdrthlpawxC6xSdaVyb+Lurpl8t3TyJczrHw=;
        b=YwdVaxZvbrNK0qYRnDZWaDcGomeHvRn5E+Jg4f2tYk172ZClw5yicQBBhuLUA8Z9KH
         0vwLUER9cHtHxnIi9Hd5Q3UQLmxt86FYnRoECuNhYvam0mFLVWgQxqi3DzFpzplnV60Q
         86gYGWXv3bfVB+NudiRC3/6puBvCoyQ1oIO1CwTYzH69Pvdnaa8QOmflqpWdS2U9JawH
         vuM/6c3djHIsE/eZRTn+J8fZhqHlvdMT1kYCReckz97Cs5jjHjac/00PPMiNq0UwK4uL
         1Zk609Z8yx7MitE+bB4XsUCHQ5L6Yx5xcQzu2anGL8PzKJh8d5QxgqtBYxnfAv21Lsdx
         6sGA==
X-Gm-Message-State: AC+VfDxVcl0wjJ/eIIFaNTZftxDJVxU1nfTsxjn7WwJ06ebMwjPnwFel
        IsapjOLcVC0mmOsdpC1F8nle3g==
X-Google-Smtp-Source: ACHHUZ4q7GAPvNl9PhSyjVJz8XZjp4tybptAmSud0iv4ZRcmwfCg4iYtk4YoFllY6NDuIZ/YAfkmsg==
X-Received: by 2002:a05:6870:2206:b0:1ad:f52:81c7 with SMTP id i6-20020a056870220600b001ad0f5281c7mr109198oaf.17.1687295314287;
        Tue, 20 Jun 2023 14:08:34 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090ad50c00b0025e2b703adesm1863846pju.41.2023.06.20.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 14:08:33 -0700 (PDT)
Date:   Tue, 20 Jun 2023 14:08:33 -0700 (PDT)
X-Google-Original-Date: Tue, 20 Jun 2023 14:07:54 PDT (-0700)
Subject:     Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <CAKwvOdm4FLSq41WTzmPqCeNh-WBX1_rtKpT3zwyGez7bZ-jE7w@mail.gmail.com>
CC:     Conor Dooley <conor@kernel.org>, jszhang@kernel.org,
        llvm@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     ndesaulniers@google.com
Message-ID: <mhng-3ceb19b1-0af6-451e-816d-8ab5c68b5fea@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 20 Jun 2023 13:47:07 PDT (-0700), ndesaulniers@google.com wrote:
> On Tue, Jun 20, 2023 at 4:41 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Tue, 20 Jun 2023 13:32:32 PDT (-0700), ndesaulniers@google.com wrote:
>> > On Tue, Jun 20, 2023 at 4:13 PM Conor Dooley <conor@kernel.org> wrote:
>> >>
>> >> On Tue, Jun 20, 2023 at 04:05:55PM -0400, Nick Desaulniers wrote:
>> >> > On Mon, Jun 19, 2023 at 6:06 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >> > > On Thu, 15 Jun 2023 06:54:33 PDT (-0700), Palmer Dabbelt wrote:
>> >> > > > On Wed, 14 Jun 2023 09:25:49 PDT (-0700), jszhang@kernel.org wrote:
>> >> > > >> On Wed, Jun 14, 2023 at 07:49:17AM -0700, Palmer Dabbelt wrote:
>> >> > > >>> On Tue, 23 May 2023 09:54:58 PDT (-0700), jszhang@kernel.org wrote:
>> >>
>> >> > > >> Commit 3b90b09af5be ("riscv: Fix orphan section warnings caused by
>> >> > > >> kernel/pi") touches vmlinux.lds.S, so to make the merge easy, this
>> >> > > >> series is based on 6.4-rc2.
>> >> > > >
>> >> > > > Thanks.
>> >> > >
>> >> > > Sorry to be so slow here, but I think this is causing LLD to hang on
>> >> > > allmodconfig.  I'm still getting to the bottom of it, there's a few
>> >> > > other things I have in flight still.
>> >> >
>> >> > Confirmed with v3 on mainline (linux-next is pretty red at the moment).
>> >> > https://lore.kernel.org/linux-riscv/20230517082936.37563-1-falcon@tinylab.org/
>> >>
>> >> Just FYI Nick, there's been some concurrent work here from different
>> >> people working on the same thing & the v3 you linked (from Zhangjin) was
>> >> superseded by this v2 (from Jisheng).
>> >
>> > Ah! I've been testing the deprecated patch set, sorry I just looked on
>> > lore for "dead code" on riscv-linux and grabbed the first thread,
>> > without noticing the difference in authors or new version numbers for
>> > distinct series. ok, nevermind my noise.  I'll follow up with the
>> > correct patch set, sorry!
>>
>> Ya, I hadn't even noticed the v3 because I pretty much only look at
>> patchwork these days.  Like we talked about in IRC, I'm going to go test
>> the merge of this one and see what's up -- I've got it staged at
>> <https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/commit/?h=for-next&id=1bd2963b21758a773206a1cb67c93e7a8ae8a195>,
>> though that won't be a stable hash if it's actually broken...
>
> Ok, https://lore.kernel.org/linux-riscv/20230523165502.2592-1-jszhang@kernel.org/
> built for me.  If you're seeing a hang, please let me know what
> version of LLD you're using and I'll build that tag from source to see
> if I can reproduce, then bisect if so.
>
> $ ARCH=riscv LLVM=1 /usr/bin/time -v make -j128 allmodconfig vmlinux
> ...
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 2:35.68
> ...
>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com> # build

OK, it triggered enough of a rebuild that it might take a bit for 
anything to filter out.

Thanks!

>
>>
>> >
>> >>
>> >> Cheers,
>> >> Conor.
>> >
>> >
>> >
>> > --
>> > Thanks,
>> > ~Nick Desaulniers
>
>
>
> -- 
> Thanks,
> ~Nick Desaulniers
