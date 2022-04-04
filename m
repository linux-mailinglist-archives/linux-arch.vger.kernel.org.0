Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD3F4F1067
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 10:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377854AbiDDICJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 04:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353440AbiDDICI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 04:02:08 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A11926543;
        Mon,  4 Apr 2022 01:00:10 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 2347xkju028714;
        Mon, 4 Apr 2022 16:59:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 2347xkju028714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649059187;
        bh=mRSrkl88X6MPyUAl/G0UVHx8GrAX6GCuLVL7n0u+/ks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XEAirzYSvqXnDJqrLgp4H8t+QJ30ttADeuv5waGEL42bT5H0cwMkMVZDrRG7EWmTc
         L3JnwkAXuMp586fIHrHavJCA/UNVR7YD5EsxleotrQliVEh3i6vub1xedO4hh/Z0b5
         nor+h0koPf2cij/37DnyQb+UrGRnCeTzOib7F2xr52/RpUIyqfkgNpJqjlM37g2OtK
         GgHL7NmgeuHw/7NoUsyesadmRhGWcrq/OEGkgzqK/uOazeHVqCD9Uj6e06bkg7tBpC
         SBx6ZDF894Z9YmLBPUTi6PC3zJSS8lfGtlq8bL/kt+3pNFPm3eTmzVQgRcrzuHd39w
         1gJdvmSAmhglw==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so8251327pjk.4;
        Mon, 04 Apr 2022 00:59:47 -0700 (PDT)
X-Gm-Message-State: AOAM532FizoPOVqg6hE0b8U+rD7caXr3iCr30Gl0ShgbeHob8xVy/O7h
        uiLN5occlLPCF4JlKmaCp1JMI94M2S2uw7C4TvQ=
X-Google-Smtp-Source: ABdhPJxWnaBSrXHahM+56O5LXG8u4laGr8U6/HeCvi57cqRV167+0SlYBPqTAxVEWfYmucoiIW1o0t3MVpVnl+FRCVY=
X-Received: by 2002:a17:902:9887:b0:151:6e1c:7082 with SMTP id
 s7-20020a170902988700b001516e1c7082mr21554760plp.162.1649059186351; Mon, 04
 Apr 2022 00:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org> <Ykqh3mEy5uY8spe8@infradead.org>
In-Reply-To: <Ykqh3mEy5uY8spe8@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 4 Apr 2022 16:58:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNARb41OvLx0qV-C-CFZHXGp59Q68vxMCLC1RsZzSBibSiw@mail.gmail.com>
Message-ID: <CAK7LNARb41OvLx0qV-C-CFZHXGp59Q68vxMCLC1RsZzSBibSiw@mail.gmail.com>
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 4, 2022 at 4:44 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Apr 04, 2022 at 03:19:48PM +0900, Masahiro Yamada wrote:
> >       vr->num = num;
> >       vr->desc = p;
> >       vr->avail = (struct vring_avail *)((char *)p + num * sizeof(struct vring_desc));
> > -     vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> > +     vr->used = (void *)(((__kernel_uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
> >               + align-1) & ~(align - 1));
>
> This really does not look like it should be in a uapi header to start
> with.


Then, could you send a proper fix?

I have no idea how to do this...



-- 
Best Regards
Masahiro Yamada
