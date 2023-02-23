Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4BB6A119E
	for <lists+linux-arch@lfdr.de>; Thu, 23 Feb 2023 22:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBWVHx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Feb 2023 16:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjBWVHw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Feb 2023 16:07:52 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8703B59E4B
        for <linux-arch@vger.kernel.org>; Thu, 23 Feb 2023 13:07:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c525d470so142676057b3.18
        for <linux-arch@vger.kernel.org>; Thu, 23 Feb 2023 13:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDy3vPr0qJRCA9dsWL1NmUMORzwIvttYPURltbFZMpc=;
        b=qsPE+UzcPzty9BFn6i2GGc1XS/LiY6mDx3u6bSw5CfBlMQflGXG8kD42uIiEB2AWNS
         4dFUL7wB9tqtDXyvHDP+y2oMv5JEqfp+WjLmt3Ziws78zc75n0eoHhz+4OyJu7ZL+4T1
         6yYwYADt4nzJNT/7/KFqstg5HWZXn3wfcyGrx5q+gj0GT/l68gf4/17J3Y2cfdstZgul
         lhULaPr7fDFDDnymEJPnUoWZ7fXQrAc+3tn4oGGFz2WbB8+AuiVQ7JQo+ubZHRBNMNAd
         GZbmLVvMXHX7kdehsO+emNo4UTDXbxZPFnUI9LcMiMG0NWB/G9TQhtlG8zqj5wASBmr9
         nqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDy3vPr0qJRCA9dsWL1NmUMORzwIvttYPURltbFZMpc=;
        b=sZLeBYIr1O3Lnkeoo2EyjWM73t025GRygFL1S3uYMR5pJPYH0s5gi/i9LLo4k0b8ZW
         yhz6DkvuFcc7vRfFij0JEhjzUkt+w8u3cdY8Bgi2X9xVMJukXt5B5JdeCutoUnkzwQjL
         DW6Onkhi0m8DRj2FuN0CeGMVwwSDZsmCSYbyKPiIXRrOsMM600shWbwFOzFQE5e0aFUn
         lDzsI9O29Zi99B49Hso248TQFO8LPG5VPGB7wXeXPHeKbGs0aF80oXXNagRunqantK4m
         657UsMjo9SdcweAJk3uYbvQN3dOow3Axhbf4eHDU5SXdJtcub4ZaB9gl6dCVAblLKudq
         FXDA==
X-Gm-Message-State: AO0yUKURiVbbi7Bq2uaushP6pgYJj34LNnARjHfzXtKB3C2aFP08wRct
        KUaE33k5+s1nCuSVaa7CL+GHl70LCBI=
X-Google-Smtp-Source: AK7set89gIznAxeDfaUj5caiC9RMffToP6dOxix8kVKieHwPx9MzyFKOjKWtkt7UHWZt7FyQXZHW+fjVykA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:287:b0:8de:ddd5:7f8e with SMTP id
 v7-20020a056902028700b008deddd57f8emr2447294ybh.4.1677186466736; Thu, 23 Feb
 2023 13:07:46 -0800 (PST)
Date:   Thu, 23 Feb 2023 13:07:45 -0800
In-Reply-To: <BYAPR21MB168836495869ABB4E3D61D61D7AB9@BYAPR21MB1688.namprd21.prod.outlook.com>
Mime-Version: 1.0
References: <BYAPR21MB16882083E84F20B906E2C847D7DE9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+aczIbbQm/ZNunZ@zn.tnic> <cb80e102-4b78-1a03-9c32-6450311c0f55@intel.com>
 <Y+auMQ88In7NEc30@google.com> <Y+av0SVUHBLCVdWE@google.com>
 <BYAPR21MB168864EF662ABC67B19654CCD7DE9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y+bXjxUtSf71E5SS@google.com> <e15a1d20-5014-d704-d747-01069b5f4c88@intel.com>
 <e517d9dd-c1a2-92f6-6b4b-c77d9ea47546@intel.com> <BYAPR21MB168836495869ABB4E3D61D61D7AB9@BYAPR21MB1688.namprd21.prod.outlook.com>
Message-ID: <Y/fVoc4C5BNI+i7l@google.com>
Subject: Re: [PATCH v5 06/14] x86/ioremap: Support hypervisor specified range
 to map as encrypted
From:   Sean Christopherson <seanjc@google.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 23, 2023, Michael Kelley (LINUX) wrote:
> From: Dave Hansen <dave.hansen@intel.com> Sent: Thursday, February 23, 2023 12:42 PM
> > 
> > On 2/23/23 12:26, Dave Hansen wrote:
> > >> +       if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
> > >> +               /*
> > >> +               * Ensure fixmaps for IOAPIC MMIO respect memory encryption pgprot
> > >> +               * bits, just like normal ioremap():
> > >> +               */
> > >> +               if (x86_platform.hyper.is_private_mmio(phys))
> > >> +                       flags = pgprot_encrypted(flags);
> > >> +               else
> > >> +                       flags = pgprot_decrypted(flags);
> > >> +       }
> > ...
> > > It does seem a bit odd that there's a new CC_ATTR_GUEST_MEM_ENCRYPT
> > > check wrapping this whole thing.  I guess the trip through
> > > pgprot_decrypted() is harmless on normal platforms, though.
> > 
> > Yeah, that's _really_ odd.  Sean, were you trying to optimize away the
> > indirect call or something?

No, my thought was simply to require platforms that support GUEST_MEM_ENCRYPT to
implement x86_platform.hyper.is_private_mmio, e.g. to avoid having to check if
is_private_mmio is NULL, to explicit document that non-Hyper-V encrypted guests
don't (yet) support private MMIO, and to add a bit of documentation around the
{de,en}crypted logic.

> > I would just expect the Hyper-V/vTOM code to leave
> > x86_platform.hyper.is_private_mmio alone unless it *knows* the platform has
> > private MMIO *and* CC_ATTR_GUEST_MEM_ENCRYPT.
> 
> Agreed.
> 
> > 
> > Is there ever a case where CC_ATTR_GUEST_MEM_ENCRYPT==0 and he
> > Hyper-V/vTOM code would need to set x86_platform.hyper.is_private_mmio?
> 
> There's no such case. 
> 
> I agree that gating with CC_ATTR_GUEST_MEM_ENCRYPT isn't really necessary.
> Current upstream code always does the pgprot_decrypted(), and as you said,
> that's a no-op on platforms with no memory encryption.

Right, but since is_private_mmio can be NULL, unless I'm missing something we'll
need an extra check no matter what, i.e. the alternative would be

	if (x86_platform.hyper.is_private_mmio &&
	    x86_platform.hyper.is_private_mmio(phys))
		flags = pgprot_encrypted(flags);
	else
		flags = pgprot_decrypted(flags);

I have no objection to that approach.  It does have the advantage of not needing
an indirect call for encrypted guests that don't support private MMIO, though
I can't imagine this code is performance sensitive.
