Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02E228879
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 20:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgGUSoK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 14:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgGUSoJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 14:44:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEDEC0619DA
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 11:44:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cv18so1755463pjb.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3LfPahCwDgYlI4ZTOgCGD9fC1JmncfD/lLqsHCCVbWU=;
        b=gIpYGseTcRAt3cbtJglK96ny0HOxl1F4IoVHOXhGC6OA9GiYAUprn5cq0v3Qk60oku
         QB3Qr0eNGhxW2wgiq1UOxgfCXcPyWOKOIZcptCpnEMbDlZnS/sX990Y/hxH3a8t6Y0WF
         KglLs08Gw2HR/h42Calo8PdHfhFbeiLXaUTcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3LfPahCwDgYlI4ZTOgCGD9fC1JmncfD/lLqsHCCVbWU=;
        b=Mb1W8y2HFN7lr7Lajicz83xWPq+hGXcPnGkHoxy3T7qc706rYP2Mm0nthnc3Sb0aAP
         ggFci+nBtMNSXa0R3wxfR09Amx1y7yx7ROF3pYhISOJRDi91RHDzzOj7carkIIM8s3iN
         B+3mtkGe/UJUbwECExTL38q8GSPcN41CNVGg+sETZm46yT95sWlMGdB4qX5hjI0GrR6M
         77MRO9/RaNTL7r3tKfsDPf4iqrvMhwPdg4fGsgUnRt2H+3Q0VmhS/QST7I+h1oahEdHw
         LVKkWxzpA1FW5x+SCCv4VmsJn8Xuz9zB1pM68xtMX2j7XumqUNt/B5XVQ2jLuCl/Si3T
         +kxw==
X-Gm-Message-State: AOAM5306VJ8UmwfVjnSKBuQNSKDCpKuUDmmKng7R2qbEdbajgtdDkcMZ
        LD+Po6gKaou7ACB+UlfJI+YOpQ==
X-Google-Smtp-Source: ABdhPJyB/3YWANGTyrbmV6E+f+nN2vwpyNyu5QDKBTxjc0vSe5agtQfARQFqwLL8aP2pPlmZzs5sYg==
X-Received: by 2002:a17:902:aa93:: with SMTP id d19mr11336859plr.272.1595357048961;
        Tue, 21 Jul 2020 11:44:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x13sm20479444pfj.122.2020.07.21.11.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 11:44:08 -0700 (PDT)
Date:   Tue, 21 Jul 2020 11:44:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Bob Haarman <inglorion@google.com>, hjl.tools@gmail.com,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] x86, vmlinux.lds: Page-Align end of ..page_aligned
 sections
Message-ID: <202007211143.AC36D096@keescook>
References: <20200721093448.10417-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721093448.10417-1-joro@8bytes.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 11:34:48AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Align the end of the .bss..page_aligned and .data..page_aligned section
> on page-size too. Otherwise the linker might place other objects on the
> page of the last ..page_aligned object. This is inconsistent with other
> objects in those sections, which all have their own page.

What problem was actually encountered? (i.e. why is it a problem for the
other data to be in the page of the page-aligned data? shouldn't those
data have their own, separate, alignment hint?)

-- 
Kees Cook
