Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF8F2CBE8F
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 14:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgLBNj7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 08:39:59 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51354 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgLBNj7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 08:39:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id v14so7314157wml.1;
        Wed, 02 Dec 2020 05:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FJ6xsLQx9dY05IPFoonCh3sF/1Zc711Of2UZIMZEMno=;
        b=NMtOa7vjYq9yFrbFk5RXqW+gXSDUYKu4Ng0XQY0KEFpmj4VNCTN7jP/wxvsyg12wME
         jAV+LmXjldUrqCYX12nBa6gaiOGFdMYhYs0wgyjEkMgk3Y6KEGbygo4E9sTHL5WkJFvB
         1ZXva6czIgbjLRWWbyJgLg26Fe0OLUGqaESsT7rI2M47klrlZw0JCEuMZVRuo4jLZ55J
         AfhLe/vYxSxM7Yb2MwgrZFBMvlI36ngM5I6JsHbkgdi9u5+muGW5BCKicAPmIHNuM8Rm
         34pDFsdujFnNhCqiKOzVAn9xMG24+av22RuJk2ABbf0uxgk5cgMI+AvLLQHUbRfVk1KC
         1QUA==
X-Gm-Message-State: AOAM530BzlxZCefH/WjsVJGQ9AFoigDQU9s06wocp8fwRGALdN3W32jE
        bRKhAP4KYp7fZVEwPDSrWss=
X-Google-Smtp-Source: ABdhPJxlQAAVuHK9QnwgrH5pU8A6gRGvEJWKj5rhzDCmCUxOYxO63UZbzgCMgwNF2JiH6J971dffLQ==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr3189754wmc.130.1606916351950;
        Wed, 02 Dec 2020 05:39:11 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s4sm2143519wru.56.2020.12.02.05.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 05:39:11 -0800 (PST)
Date:   Wed, 2 Dec 2020 13:39:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Rob Herring <robh@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 12/17] asm-generic/hyperv: update hv_interrupt_entry
Message-ID: <20201202133910.6pihxjpu4qq5ljy5@liuwe-devbox-debian-v2>
References: <20201124170744.112180-1-wei.liu@kernel.org>
 <20201124170744.112180-13-wei.liu@kernel.org>
 <012811843c94694f595e11bebfd9d4075f81f7f2.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012811843c94694f595e11bebfd9d4075f81f7f2.camel@infradead.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 24, 2020 at 06:05:27PM +0000, David Woodhouse wrote:
> On Tue, 2020-11-24 at 17:07 +0000, Wei Liu wrote:
> > We will soon use the same structure to handle IO-APIC interrupts as
> > well. Introduce an enum to identify the source and a data structure for
> > IO-APIC RTE.
> > 
> > While at it, update pci-hyperv.c to use the enum.
> > 
> > No functional change.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> The I/OAPIC is just a device for generating MSIs.
> 
> Can you check if this renders your patch obsolete:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/apic&id=5d5a97133887b2dfd8e2ad0347c3a02cc7aaa0cb

David, thanks for your comment.

This patch merely copies the definitions from Microsoft Hypervisor. The
data structure is the exact one that is returned from the hypervisor.
The hypervisor doesn't return a pair of (addr,data). It translates
(addr,data) to IO-APIC RTE for the caller -- like what
ioapic_setup_msg_from_msi does in your patch.

I don't think your patch makes this patch obsolete.

Wei.
