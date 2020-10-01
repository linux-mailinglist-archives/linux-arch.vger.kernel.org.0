Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA88C280154
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 16:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbgJAOdb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 10:33:31 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:41740 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgJAOdb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 10:33:31 -0400
Received: by mail-oo1-f68.google.com with SMTP id t3so1519427ook.8;
        Thu, 01 Oct 2020 07:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NklUCDIMExUICy4FN/gh63Vm3SmGzKI/5Dwr1ozJ1xo=;
        b=Uye2+7mYqgX89ErfbrN19Ywi5H8ep5QlB475QIIkeLx+4MtiZnluCT8Ayj5oMDuah/
         X3VI3p/1xoRqc90ue14+uRGHnU5T+CSbBpMNCSFUONviMRdPluG6VhyZ6t0ziOVpQWf5
         5qCqbSFAajrV5sYt0fdIrqEMgWlg4/MjNQmuL64DscaMXWLG3LY+K0QN2ALwTqxXrvqy
         GCoRbjPuzRTBi4AYoed1PjP6LlxxLSB+ML80CitU301Z2aeickSJi3B6oQf6v4euVWP5
         SkhFJMXhoRNuSlZ5MdR9ZBkO768iwigMNOj0Vh1UBc+6Auk0tdurJFS9V1RyzA7gvUNm
         BP5Q==
X-Gm-Message-State: AOAM533Hwl06GCV8x1+z+TBM6dt/UsBDrObdk66WFuJF8qPyGRaf2r67
        A05UQ3DCgg1cCo29Sksj4ewRms3+EF2z
X-Google-Smtp-Source: ABdhPJwtom5klA/Ap8NrMcL34dnJEga9NT+pmkNy471CG5ehIqBT2YW5RiioY1ZL73r4Gt8Hdb3wCQ==
X-Received: by 2002:a4a:95f1:: with SMTP id p46mr5633028ooi.93.1601562808922;
        Thu, 01 Oct 2020 07:33:28 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g7sm1204483otk.56.2020.10.01.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:33:28 -0700 (PDT)
Received: (nullmailer pid 695955 invoked by uid 1000);
        Thu, 01 Oct 2020 14:33:22 -0000
Date:   Thu, 1 Oct 2020 09:33:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Stephen Hemminger <sthemmin@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        virtualization@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>
Subject: Re: [PATCH RFC v1 12/18] asm-generic/hyperv: update
 hv_interrupt_entry
Message-ID: <20201001143322.GA695896@bogus>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914115928.83184-4-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914115928.83184-4-wei.liu@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 14 Sep 2020 11:59:21 +0000, Wei Liu wrote:
> We will soon use the same structure to handle IO-APIC interrupts as
> well. Introduce an enum to identify the source and a data structure for
> IO-APIC RTE.
> 
> While at it, update pci-hyperv.c to use the enum.
> 
> No functional change.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c |  2 +-
>  include/asm-generic/hyperv-tlfs.h   | 36 +++++++++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
