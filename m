Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A8B26CA23
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 21:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgIPTsk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Sep 2020 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbgIPRhz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Sep 2020 13:37:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D091C0A8886
        for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2020 05:40:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l9so2861811wme.3
        for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2020 05:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SHWTqsRrpvdPx0tBOPELgE5HkWuQTwHGc/3aI5QE1HY=;
        b=QehNvtX2SryaVlrh3oRpLKvQXaA321J8J2rWE9nBVHLPUgI50PzqYEAcIABF380PtC
         9NDRWzgncEP4mNNOlban8PDvDL3FswoMuuayj43rhl2+HUxXOjVL4XW+VclSGMdA2Og8
         GE1XRR+LNnVc2sBlNMBhTJ+mGrWaZtP+tSLTYIP3RQRjsEmctstJK2cuxjdbE6gjknON
         q/PrKStFzGteU3RCiUUzijYZu4vWgo2JYbOm/2xX9M5Y6ptZZzPkdW7aN380hBPAbV/n
         5nqrdkvrNbRtueRtfWsbTNFvSh6Qx9L7B7C5Q5gMhhctF8cYq9ZRRPQMNzZD6znaGJK8
         xjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SHWTqsRrpvdPx0tBOPELgE5HkWuQTwHGc/3aI5QE1HY=;
        b=seShO4wswcWVVu7uy1NPpPHOrWo4CixDltPFUq0iGJZdkWyTN3Cusjgqc1ycEfdtvP
         A9j6CMdkNtBMBYFcp8BCXsZKX2MZovNn6bQAljB7AN1PtX1oXn8i8o1JsTkAmBb/L9OK
         CPgbSZkfgl8ISA+AsFf4lqddta+E0Jm+Ou3J6L/oL9de2p1wRseoVPDSzYXaUqVE2+l/
         sKStPL4MZZJjlxuJtpwyWdvVkAFMmRPOWqgfjFtCEFTyIXEbtY6jDmU5HgezKT902dl4
         vbViCOSnke8MtLI3w63icnyk40qN2gq0dPTQgOwhWFSmENMoUCsnu6Ksz8xRXOa04INX
         aH7w==
X-Gm-Message-State: AOAM533fo7VNHrVgzA5nVPThKhL3KInkbXiDQxvVVnZyt1Sgtt2PxlSW
        UQZxEwg7xmfxWmy80I3rcoL3hw==
X-Google-Smtp-Source: ABdhPJwA4P8SpiiyN27RMOw1Mmmvb2s4C9MzoRrI8V/f6GP5+OmiwBGeC9tuLCDkSa/+obWc5Z4Rmg==
X-Received: by 2002:a1c:f415:: with SMTP id z21mr4520772wma.88.1600260047425;
        Wed, 16 Sep 2020 05:40:47 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id 10sm5250595wmi.37.2020.09.16.05.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 05:40:46 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:40:45 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 00/10] Independent per-CPU data section for nVHE
Message-ID: <20200916124045.stlrdh5lvedpzab4@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
 <20200914174008.GA25238@willie-the-truck>
 <20200916115404.rhv4dkyjz35e4x25@google.com>
 <20200916122412.elxfxbdygvmdgrj5@google.com>
 <20200916123913.GA28056@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916123913.GA28056@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> >  SECTIONS {
> >         HYP_SECTION(.text)
> > -       HYP_SECTION(.data..percpu)
> > -       HYP_SECTION(.data..percpu..first)
> > -       HYP_SECTION(.data..percpu..page_aligned)
> > -       HYP_SECTION(.data..percpu..read_mostly)
> > -       HYP_SECTION(.data..percpu..shared_aligned)
> > +
> > +       .hyp..data..percpu : {
> 
> Too many '.'s here?
Oops

> 
> > +               __per_cpu_load = .;
> 
> I don't think we need this symbol.
True

> 
> Otherwise, idea looks good to me. Can you respin like this, but also
> incorporating some of the cleanup in the diff I posted, please?

On it! :)

David
