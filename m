Return-Path: <linux-arch+bounces-1775-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AAC840A13
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 16:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C813C1C221E8
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962A6153BDC;
	Mon, 29 Jan 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QPBMraaO"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB8C153BD0;
	Mon, 29 Jan 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542378; cv=none; b=NK1Tcp3fhkgMaeXNCjfsGH3iY8DlgWE2MWt2oYCWfI/C+wG64cB2NomrcF3IA87QAY24ZBdckD5C0fP+COgf0Mja6ivQ+rmKluXKPRDo5s2Sg00JiJpkN3eR4pfzkmIwbc79C6wWfxZ6EHm/9//hYDMQNQwivtBM9eD3QBxwZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542378; c=relaxed/simple;
	bh=M4Ydsjad/swrZwcvf7pSn8N8hCrpUpA9lm6//wf5n4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5ERMqVEikUpyZL6hgr6rCDXAbXNWS2OHp7Fn9HRa207YqS+G/x4EHAJRKdrTHA+bUKLexEkX6mAHewAwY9j3f0gClThOVN8uhpQxyHGS6qimaygecm0OD7tapyb5igBriLPNhhS3/PiM/Q/885Uy3DSdtfMZAVeJUDLsKzwZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QPBMraaO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CrHCTlFRqhVi35tK959UuBbKAaE+0blDjjqiPB7oOOk=; b=QPBMraaOzb39X/fTDTDp8vZn3U
	RyQNYMvVEuosY1G2SF9dOmBcU/EIjaw/4q1ZtewTtTqBR2ZTFc0HwNzLEMLV2PL1R+6KEJM2hgN8y
	y27brvTJVMBs3/Kx16Qyd0F6UgR6nO91iHksI1MULxx1Uv/MoCL4CJVPMswAs3vMX+z1pVQoWF9mP
	ciarx1HSr1oQZTuCJWBn/mylPek1/6qnmqyWafXtUnzD171hxxU3T2/IBjNv4sD9GCQi2Sz5aNUJ2
	NpFd5Kwem/2q2pdUrG702/gdn6SHY1d9fOFivlToOyVuVDMwEArwj3mFhJINI1ddPyf7tn0gTM/tU
	xrrJkCOA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40068)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rUTcv-0000bZ-0j;
	Mon, 29 Jan 2024 15:32:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rUTcp-0004f6-8p; Mon, 29 Jan 2024 15:32:43 +0000
Date: Mon, 29 Jan 2024 15:32:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>, vishnu@os.amperecomputing.com,
	miguel.luis@oracle.com
Subject: Re: [PATCH RFC v3 03/21] ACPI: processor: Register CPUs that are
 online, but not described in the DSDT
Message-ID: <ZbfFG5JLnAkGN1pk@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOg2-00Dvjk-RI@rmk-PC.armlinux.org.uk>
 <CAJZ5v0ju1JHgpjuFLHZVs4NZiARG6iBZN_wza6c2e0kDhZjK0w@mail.gmail.com>
 <ZaURtUvWQyjYfiiO@shell.armlinux.org.uk>
 <20240122160227.00002d83@Huawei.com>
 <CAJZ5v0hamuXJ_w-TSmVb=5jGide=Lb7sCjbzzNb_rFuPrvkgxQ@mail.gmail.com>
 <Za6mHRJVjb6M1mun@shell.armlinux.org.uk>
 <20240123092725.00004382@Huawei.com>
 <20240129130354.0000042b@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129130354.0000042b@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 29, 2024 at 01:03:54PM +0000, Jonathan Cameron wrote:
> I poked this on x86 - it only applies with hotplug enabled anyway so
> same result as doing the hotplug later - All possible Processor() entries
> already exist in DSDT. Hence this isn't the source of the mysterious
> broken configuration.
> 
> If anyone does poke this path, the old discussion between James
> and Salil provides some instructions (mostly the thread is about
> another issue).
> https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/thread/DNAGB2FB5ALVLV2BYWYOCLKGNF77PNXS/
> 
> Also on x86 a test involving smp 2,max-cpus=4 and adding cpu-id 3
> (so skipping 2) doesn't boot. (this is without Salil's QEMU patches).
> I guess there are some well known rules in there that I don't know about
> and QEMU isn't preventing people shooting themselves in the foot.
> 
> As I'm concerned, drop this patch.
> If there are platforms out there doing this wrong they'll surface once
> we get this into more test farms (so linux-next).  If we need this
> 'fix' we can apply it when we have a problem firmware to point at.

Now dropped.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

