Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF5B30DB2A
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 14:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhBCN0r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 08:26:47 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:36678 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhBCN0p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 08:26:45 -0500
Received: by mail-wm1-f43.google.com with SMTP id i9so5229102wmq.1;
        Wed, 03 Feb 2021 05:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y4q+v0wWRtdknCDT+I8fxPC73fGYrwzICDkzu3nG7So=;
        b=LAl2mYNV2CThFCk3/DvRkzFp9K8toivjFzUMuyEL55AnRk0j1Md6rJ3ODnkkQGibp1
         BBGxE8iexOXcCXarOuhKvYG2HmnVWPhEBH/DZhzpR5E8VRA7ch+AUZdRgfqauS9jHOme
         m7yQpcATyg1w4uCE8FPxjzMSWRlH5Yz4PW4V+po3RD1+dj7IOw783IbgxGirlW8P4jxT
         pDOoYftGjgrKqSKZKM/SuD1mvnx5J/dAS5DY6uEHc7gOl08FsfvKbQCIUE++oPaD8kzO
         qW8odTTXpLqUPvSYqAhUEzq5edUKUwK8VljRjzKUrrK8PrQuE4ovSseDdvDftyc7EDi1
         OXwA==
X-Gm-Message-State: AOAM531Ta9HeFIhylXRZBX+PmjJrg3ByOPLpEhC4WSYMbAb0LrHKn+N1
        H3CU5alt3sehAMXVfyHC7R4=
X-Google-Smtp-Source: ABdhPJwiz7s1Ug8HtLd4gUb16Jr0f9pGdBe1ZBy1T+U3CwviMLRzhjyaq+LqZ4t04TpHEaWB6Fr6RA==
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr2894128wmg.42.1612358763107;
        Wed, 03 Feb 2021 05:26:03 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id 62sm2937981wmd.34.2021.02.03.05.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 05:26:02 -0800 (PST)
Date:   Wed, 3 Feb 2021 13:26:01 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v5 13/16] asm-generic/hyperv: introduce hv_device_id and
 auxiliary structures
Message-ID: <20210203132601.ftpwgs57qtok47cg@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-14-wei.liu@kernel.org>
 <MWHPR21MB1593959647DA60219E19C25ED7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20210202170248.4hds554cyxpuayqc@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202170248.4hds554cyxpuayqc@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 02, 2021 at 05:02:48PM +0000, Wei Liu wrote:
> On Tue, Jan 26, 2021 at 01:26:52AM +0000, Michael Kelley wrote:
> > From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> > > 
> > > We will need to identify the device we want Microsoft Hypervisor to
> > > manipulate.  Introduce the data structures for that purpose.
> > > 
> > > They will be used in a later patch.
> > > 
> > > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > ---
> > >  include/asm-generic/hyperv-tlfs.h | 79 +++++++++++++++++++++++++++++++
> > >  1 file changed, 79 insertions(+)
> > > 
> > > diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> > > index 8423bf53c237..42ff1326c6bd 100644
> > > --- a/include/asm-generic/hyperv-tlfs.h
> > > +++ b/include/asm-generic/hyperv-tlfs.h
> > > @@ -623,4 +623,83 @@ struct hv_set_vp_registers_input {
> > >  	} element[];
> > >  } __packed;
> > > 
> > > +enum hv_device_type {
> > > +	HV_DEVICE_TYPE_LOGICAL = 0,
> > > +	HV_DEVICE_TYPE_PCI = 1,
> > > +	HV_DEVICE_TYPE_IOAPIC = 2,
> > > +	HV_DEVICE_TYPE_ACPI = 3,
> > > +};
> > > +
> > > +typedef u16 hv_pci_rid;
> > > +typedef u16 hv_pci_segment;
> > > +typedef u64 hv_logical_device_id;
> > > +union hv_pci_bdf {
> > > +	u16 as_uint16;
> > > +
> > > +	struct {
> > > +		u8 function:3;
> > > +		u8 device:5;
> > > +		u8 bus;
> > > +	};
> > > +} __packed;
> > > +
> > > +union hv_pci_bus_range {
> > > +	u16 as_uint16;
> > > +
> > > +	struct {
> > > +		u8 subordinate_bus;
> > > +		u8 secondary_bus;
> > > +	};
> > > +} __packed;
> > > +
> > > +union hv_device_id {
> > > +	u64 as_uint64;
> > > +
> > > +	struct {
> > > +		u64 :62;
> > > +		u64 device_type:2;
> > > +	};
> > 
> > Are the above 4 lines extraneous junk? 
> > If not, a comment would be helpful.  And we
> > would normally label the 62 bit field as 
> > "reserved0" or something similar.
> > 
> 
> No. It is not junk. I got this from a header in tree.
> 
> I am inclined to just drop this hunk. If that breaks things, I will use
> "reserved0".
> 

It turns out adding reserved0 is required. Dropping this hunk does not
work.

Wei.
