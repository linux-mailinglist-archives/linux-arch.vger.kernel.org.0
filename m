Return-Path: <linux-arch+bounces-511-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0F7FBE53
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 16:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D08282A76
	for <lists+linux-arch@lfdr.de>; Tue, 28 Nov 2023 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1811E497;
	Tue, 28 Nov 2023 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ufy1zdMP"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A649B1BFB;
	Tue, 28 Nov 2023 07:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mVq2VBDdj0t3XTFpvUrIvhiR+YY+OvU4QSPCYJWGc8E=; b=ufy1zdMPMnVNIF/+ov14F3j8Ec
	hSNNKbburJyOOd0Vu77/1DsGFYg1/k2jyDDkLGGyO7igXqFwYlFp/MXMEAqR6ubePwruwhjwft5k5
	6XvP2Qx0spxm49FR5cyHB0fBLz4ezydx2jacG3egTq6D+JPkb+Dbj3knxuLcyzghEvrMD40UCo54r
	Jea+R67qjbDvLlond0PUqh6OsCh5y8mmOR9Y1xdg3Mie8Gw2MBELJXIFL8lx7dYBc0vzhGVy48lst
	3ha7TGA1J+qq6xBBVxbS7fUQuz36JnhldrCxVm/rfHOoUgGnNqBqEU9rGr+JohxdeJxwdpZB1agJG
	zt8l8DSQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53676)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r80DS-0007XV-0T;
	Tue, 28 Nov 2023 15:41:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r80DR-00034d-NZ; Tue, 28 Nov 2023 15:41:37 +0000
Date: Tue, 28 Nov 2023 15:41:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC 01/22] arch_topology: Make
 register_cpu_capacity_sysctl() tolerant to late CPUs
Message-ID: <ZWYKMWCNdvWV2ks8@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JKl-00CTwT-Hx@rmk-PC.armlinux.org.uk>
 <20231128143722.000032db@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128143722.000032db@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Nov 28, 2023 at 02:37:22PM +0000, Jonathan Cameron wrote:
> On Tue, 07 Nov 2023 10:29:23 +0000
> Russell King <rmk+kernel@armlinux.org.uk> wrote:
> 
> > From: James Morse <james.morse@arm.com>
> > 
> > register_cpu_capacity_sysctl() adds a property to sysfs that describes
> > the CPUs capacity. This is done from a subsys_initcall() that assumes
> > all possible CPUs are registered.
> > 
> > With CPU hotplug, possible CPUs aren't registered until they become
> > present, (or for arm64 enabled). This leads to messages during boot:
> > | register_cpu_capacity_sysctl: too early to get CPU1 device!
> > and once these CPUs are added to the system, the file is missing.
> > 
> > Move this to a cpuhp callback, so that the file is created once
> > CPUs are brought online. This covers CPUs that are added late by
> > mechanisms like hotplug.
> > One observable difference is the file is now missing for offline CPUs.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> > If the offline CPUs thing is a problem for the tools that consume
> > this value, we'd need to move cpu_capacity to be part of cpu.c's
> > common_cpu_attr_groups.
> 
> I'm not keen on squirting sysfs files in from code so
> might be nice to do that anyway and use is_visible() / sysfs_update_group()
> but that would be a job for another day if at all.

I'm doing my best, but it's really not helped by the dysfunctional
nature of some parts of the kernel community. I have now decided that
this is not possible to implement. So while it's a nice idea, I don't
think we'll ever see it.

As I mentioned on the 14th November, complete with a patch (and got no
response from anyone):
> Looking into doing this, the easy bit is adding the attribute group
> with an appropriate .is_visible dependent on cpu_present(), but we
> need to be able to call sysfs_update_groups() when the state of the
> .is_visible() changes.
>
> Given the comment in sysfs_update_groups() about "if an error occurs",
> rather than making this part of common_cpu_attr_groups, would it be
> better that it's part of its own set of groups, thus limiting the
> damage from a possible error? I suspect, however, that any error at
> that point means that the system is rather fatally wounded.
>
> This is what I have so far to implement your idea, less the necessary
> sysfs_update_groups() call when we need to change the visibility of
> the attributes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

