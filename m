Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F4933CAD4
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 02:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhCPBSj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Mar 2021 21:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhCPBSZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Mar 2021 21:18:25 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF54C06174A
        for <linux-arch@vger.kernel.org>; Mon, 15 Mar 2021 18:18:24 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id o16so4548761pgu.3
        for <linux-arch@vger.kernel.org>; Mon, 15 Mar 2021 18:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :user-agent:mime-version;
        bh=ff1rWIO8ONBhu+9mkwYDYBw8H5yECZzZ/LJzxXqc+Mc=;
        b=jabAFlcw2cACmxXTbiDOil5i7nYHy1OU66LFA7xKvERdJ7hjmF6PYrPtYBhTprIGll
         70h5MeX0qTm2LX0g61vRffyHOiaPAVS2eZwmvTypD4tYf4wp6MzP0xEVA4hmkCQbcQBo
         j800abUa/h2BUtohSFoCWOckIVCrKoMOJJTaxNblE6p5Lhsq4NC1Ve+xatXzUxLouItK
         9Zjhga4xB3ByP4RX0ouHwF+WhxWH1MpjTKIKVBJ2QKi/ix468/x/s8qh91Ux01gB0DuZ
         f0GLssAOIPM4T7LP4wSfhhpxKSFLxV9je69eWrzEg4oTl/5K9r2Oz9Rpv6rzWg3om3+j
         mCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:user-agent:mime-version;
        bh=ff1rWIO8ONBhu+9mkwYDYBw8H5yECZzZ/LJzxXqc+Mc=;
        b=G/yR1YvOVmeX7vgnbAzkeHIVGDChfSzy5/PlyUg6/bTMBtO53PdgWVnXPH4KvXC5oJ
         so8NY9P5GneG30bn/kWCE5s5o7KdPBO7ulQak1Jy6YNu0hZTyR60NeTHYSh8XunnFPCk
         jPWgKSXIss8QrEBX9HLaMfvopEnX/NFra7Ii5+D2tKzskATG5Fy5mSYmt2EAywV8zz6g
         xnRUmHb6deQOOhMttMAF0u7eZviyvk/28lCz/NobCX7PgA+DX4z2TgCZrFwdPY4DpWaT
         FKE41xx7MrqMxBE17Yk7XYejNf79Hd96b4cD7o043FUgJSNhhZe8EncQD9LBU626ZPK0
         1v7A==
X-Gm-Message-State: AOAM532RjI+EoEs34cWhxzMcM/2mmUZUlacaVnbKlozYhM6MmQNma76f
        SzIns22gy2bXagg3OY/XVRo=
X-Google-Smtp-Source: ABdhPJwjBFK7YNPh5I8fN7zZ2AaUJBcQA5zAQ+czjdc8l11fhWYVylo6Rs6yfMztiDnJtxbjdcEX8Q==
X-Received: by 2002:a63:4462:: with SMTP id t34mr1526931pgk.389.1615857503941;
        Mon, 15 Mar 2021 18:18:23 -0700 (PDT)
Received: from sun.local.gmail.com (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id mp21sm36935pjb.16.2021.03.15.18.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 18:18:23 -0700 (PDT)
Date:   Tue, 16 Mar 2021 10:18:22 +0900
Message-ID: <m28s6nc2w1.wl-thehajime@gmail.com>
From:   Hajime Tazaki <thehajime@gmail.com>
To:     johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        retrage01@gmail.com
Subject: Re: [RFC v8 08/20] um: lkl: memory handling
In-Reply-To: <03c74a353c87994b61450ba8086f1ccda40b2ea8.camel@sipsolutions.net>
References: <cover.1611103406.git.thehajime@gmail.com>
        <19d4990f2ef77ad595248183071da5e43149931c.1611103406.git.thehajime@gmail.com>
        <03c74a353c87994b61450ba8086f1ccda40b2ea8.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.1 Mule/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On Mon, 15 Mar 2021 01:53:01 +0900,
Johannes Berg wrote:
> 
> 
> > 
> > +#else
> > +
> > +#include <asm-generic/nommu_context.h>
> > +
> > +extern void force_flush_all(void);
> > 
> nit: no need for "extern"

thanks, will fix this.

> > +#define CONFIG_KERNEL_RAM_BASE_ADDRESS memory_start
> > +#include <asm-generic/page.h>
> > +
> > +#define __va_space (8*1024*1024)
> > +
> > +#ifndef __ASSEMBLY__
> > +#include <mem.h>
> 
> Is that <shared/mem.h>? I think we should start including only with that
> prefix.

okay, will fix it.

> > +
> > +void *uml_kmalloc(int size, int flags)
> > +{
> > +	return kmalloc(size, flags);
> > +}
> 
> That could probably still be shared?

This function is a stub of arch/um/kernel/mem.c, which LKL doesn't
use for the build.  Thus we defined here.

Or are you suggesting to not stubbing this function, but extracting
the function from mem.c ?

> > +int set_memory_ro(unsigned long addr, int numpages)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +int set_memory_rw(unsigned long addr, int numpages)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +int set_memory_nx(unsigned long addr, int numpages)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> > +int set_memory_x(unsigned long addr, int numpages)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> 
> UML for now no longer has these either.

Ah, I see the changes.  Will fix them.

-- Hajime
