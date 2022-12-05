Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D371D642386
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 08:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiLEHXK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 02:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiLEHXJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 02:23:09 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2205B1F6
        for <linux-arch@vger.kernel.org>; Sun,  4 Dec 2022 23:23:07 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id h10so12494282ljk.11
        for <linux-arch@vger.kernel.org>; Sun, 04 Dec 2022 23:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P3yE5QioYLPBdRrheVQTeMKHmEb+i0C+Uxq8lZYH3bI=;
        b=hzLBzBCj/UTbf0W32P0cXQWBb9OToirON8fO2yjbciQEZmAyEJtzkOKWClJCBoGSXZ
         NazQEwwhj7x2OSE63q9Gu0S4nNQoAwRDJVPDxjMI/Ma0kCILMEjg8qERnfSigkfXkTFe
         L63okalmpzjNwmywAB4I2xPlYx1mfbN8OSLO1S2nydo9A5tBbr5pDIyuRxKY6kXHaycC
         sE2B79qAeTOdn1Sm55lHeYqo67S2vAgamr8Z4Hq9TiH5SBgLegX23fPT+yhD1/TFVvW+
         dYeDpbw5lnFNeDBF0cOdbgRIqkDq0PdnDuQ4z8RkArG+9K1xXe0d1IUH0ZVSIM01oxRw
         sRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3yE5QioYLPBdRrheVQTeMKHmEb+i0C+Uxq8lZYH3bI=;
        b=pk54jTirAeeLiXHnsiIwsUWLBhViV1a8AtwO+RK9cXDo0TlPB9yl/DsvwJxMPcB45k
         P/jfcTmGfpsBRwIh/TBVREkpmzkiRlbg8RZ+Ceb6in7AeYKfY1LbUK0oDqcm8howBf5H
         IqY/66pa3sObuVKruDccjcRec0WvaOypcTa247RiuVCAuwHYFX84aYJOBh/IUpM6nM7b
         P4+Afo6MNkGnzScUWKOW0tF5kN0S6F4TDiV6hwLIiXaboArE6o6lnSG2Rie2wWNZDL7t
         jQDrL52hm8XNcZPQsJIScy/xGm7zst7Jx+ZhJGxJVum6bbtMvIMsAWX+fRh7MAxSMRx3
         oFSA==
X-Gm-Message-State: ANoB5plj8/GUXiC4eZ9vJsnS9TzUdN8eEHJItlgkjWozwx2//rLnTob5
        htNiTOEmCxfnvK0zJDc0Fyo=
X-Google-Smtp-Source: AA0mqf5+CieE6QDHh85+9Q/epKhfM7CeYJKsYqEo98af3XXlgBCqgnPuQvE2zewUADVd0YWy+71Dlg==
X-Received: by 2002:a2e:b88f:0:b0:277:f46:617b with SMTP id r15-20020a2eb88f000000b002770f46617bmr24206778ljp.221.1670224985808;
        Sun, 04 Dec 2022 23:23:05 -0800 (PST)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id m6-20020ac24286000000b004b501497b6fsm2018851lfh.148.2022.12.04.23.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 23:23:04 -0800 (PST)
Date:   Mon, 5 Dec 2022 10:23:04 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>
Subject: Re: [PATCH RFC v2 1/3] riscv: add support for hardware
 breakpoints/watchpoints
Message-ID: <Y42cWLG9+EU+Ew9B@curiosity>
References: <20221203215535.208948-1-geomatsi@gmail.com>
 <20221203215535.208948-2-geomatsi@gmail.com>
 <Y40wmUcqMQWQLBsI@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y40wmUcqMQWQLBsI@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> > RISC-V backend for hw-breakpoint framework is built on top of SBI Debug
> > Trigger extension. Architecture specific hooks are implemented as kernel
> > wrappers around ecalls to SBI functions. This patch implements only a
> > minimal set of hooks required to support user-space debug via ptrace.
> > 
> > Signed-off-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index 2a0ef738695e..ef41d60a5ed3 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -31,6 +31,9 @@ enum sbi_ext_id {
> >  	SBI_EXT_SRST = 0x53525354,
> >  	SBI_EXT_PMU = 0x504D55,
> >  
> > +	/* Experimental: Debug Trigger Extension */
> > +	SBI_EXT_DBTR = 0x44425452,
> > +
> >  	/* Experimentals extensions must lie within this range */
> >  	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
> >  	SBI_EXT_EXPERIMENTAL_END = 0x08FFFFFF,
> 
> This is an RFC for something I know nothing about, so was just scrolling
> mindlessly... This caught my eye as odd - There's an explicit comment
> about the range for experimental stuff but you've not used it? I guess
> there must be some reason for that?

IIUC it is not so experimental. This SBI extension accompanies the debug
spec v1.0 (frozen but not yet ratified). So sooner or later is going
to become a part of SBI spec.

I am using EID suggested in the draft v4 for this extension
posted at lists.riscv.org tech-debug mailing list, see:
https://lists.riscv.org/g/tech-debug/topic/92375492

Regards,
Sergey
