Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852844B1DAB
	for <lists+linux-arch@lfdr.de>; Fri, 11 Feb 2022 06:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiBKFYJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Feb 2022 00:24:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiBKFYJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Feb 2022 00:24:09 -0500
X-Greylist: delayed 97915 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 21:24:08 PST
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D5F558E;
        Thu, 10 Feb 2022 21:24:08 -0800 (PST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 21B5Nd5D013458;
        Fri, 11 Feb 2022 14:23:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 21B5Nd5D013458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644557019;
        bh=YLkBkuR1U+jQHwVN/aG4iVNRqXdadclQuIILONhbIjY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q66m5q7WkKum132uEFi8h+OaMjzBXPhEW+wTSfWLDSwWP2vdwIysY4Qa4zshNVfpD
         dCHuAM9xTKVzQhTEyElBuERIxSUgyqul7MnamKbZbGrBv+1TCW1Z6edzWlkUyPfSev
         qmhVyxlg99/yfsRBF9gefhTYD2mnHV3QSg38CNHIpzzm14p6VmBbDr7WK+G/2zvBBk
         ez1A2Q+Rlzo8Wnyx8gr0qJsOR8n2uzoXyxxvnrYRpfUob2VDIYBBs1/HDXARNqYfQN
         c2NTneauVAGhtd91LM/nqLG+xuFQKbSm/6Yj5F6U1odQEqa5itGRPTj3u/8uxGxxac
         k/+zNh6QFIR9g==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso10949649pjg.0;
        Thu, 10 Feb 2022 21:23:39 -0800 (PST)
X-Gm-Message-State: AOAM533Q05WfxvxcsQINPFq0STwgHHR9JMRGv79yhy84cwMGdIaCay+R
        6Li5/w1aU2QLCx6bonuQYzAmF/drI0VoKnn8uM4=
X-Google-Smtp-Source: ABdhPJz+PKju5x1pJ9BLVRECLUS31oqFpM+kKLWB59S5rETYSrnr/4WKSfRdirM9eCzG7Qpo2to+dCHMHJRsZXRDpeE=
X-Received: by 2002:a17:902:e782:: with SMTP id cp2mr123201plb.162.1644557018773;
 Thu, 10 Feb 2022 21:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20220210021129.3386083-1-masahiroy@kernel.org> <CAK8P3a3uZJuf9naTerxMdUeW4CEuvfK0knC0JDTZteYHPqddTw@mail.gmail.com>
In-Reply-To: <CAK8P3a3uZJuf9naTerxMdUeW4CEuvfK0knC0JDTZteYHPqddTw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 11 Feb 2022 14:23:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNATPU6yc4i15i2XDCKDMEjwUK9H3TSYP9b8qkrhsuSRXLw@mail.gmail.com>
Message-ID: <CAK7LNATPU6yc4i15i2XDCKDMEjwUK9H3TSYP9b8qkrhsuSRXLw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add more export headers to compile-test coverage
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 10, 2022 at 6:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 10, 2022 at 3:11 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > Masahiro Yamada (6):
> >   signal.h: add linux/signal.h and asm/signal.h to UAPI compile-test
> >     coverage
> >   shmbuf.h: add asm/shmbuf.h to UAPI compile-test coverage
> >   android/binder.h: add linux/android/binder(fs).h to UAPI compile-test
> >     coverage
> >   fsmap.h: add linux/fsmap.h to UAPI compile-test coverage
> >   kexec.h: add linux/kexec.h to UAPI compile-test coverage
> >   reiserfs_xattr.h: add linux/reiserfs_xattr.h to UAPI compile-test
> >     coverage
>
> Very nice! Should I pick these up into the asm-generic tree?
>
>       Arnd


Yes, please.


-- 
Best Regards
Masahiro Yamada
