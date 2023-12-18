Return-Path: <linux-arch+bounces-1121-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D358816DBF
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 13:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851731C22E97
	for <lists+linux-arch@lfdr.de>; Mon, 18 Dec 2023 12:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D414B143;
	Mon, 18 Dec 2023 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="C2KaLUoh"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA74F899;
	Mon, 18 Dec 2023 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=08SzGJH5lXG9BtLXnSCiZJkgfUYvZPRLdF1MiDN6maA=; b=C2KaLUoh/n1BgxKSf6SrAbqvai
	JKrWWotA8ePs91dXAVLuwjEpSY5ePbNax2YRNGRaUBgp7XlJSEVD5M4TKEtLw4VeIHgs2tqfFO7aM
	dxhfjGyheynixij5MnQ9UsD+vCLAUH1h1KZirAZWC8js4LRKy1n3PwI3uBnUi1JZVY2U7Ihv5/Mor
	rJp5cRqch1rnSU/tEZFmu+buYl/SCLuuuxAXtVHXXphaJjFugXWAG6myDphxhCF2EwzotxfXC/uJ4
	u6LnZqqFeEf53FdSsSiRJvxxjxBXV5gsbJXRjyqKyBk1ikWGT5yxqUY1944KT5NF09+Aqz0ttUPbl
	JFeOLJUA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54580)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rFCVj-0005GR-2l;
	Mon, 18 Dec 2023 12:14:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rFCVi-0006hJ-Np; Mon, 18 Dec 2023 12:14:14 +0000
Date: Mon, 18 Dec 2023 12:14:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
	x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 21/21] cpumask: Add enabled cpumask for present
 CPUs that can be brought online
Message-ID: <ZYA3lmPOwIOJq/iY@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOhX-00Dvlg-Ci@rmk-PC.armlinux.org.uk>
 <20231215171831.00004a19@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215171831.00004a19@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 15, 2023 at 05:18:31PM +0000, Jonathan Cameron wrote:
> On Wed, 13 Dec 2023 12:50:59 +0000
> Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> 
> > From: James Morse <james.morse@arm.com>
> > 
> > The 'offline' file in sysfs shows all offline CPUs, including those
> > that aren't present. User-space is expected to remove not-present CPUs
> > from this list to learn which CPUs could be brought online.
> > 
> > CPUs can be present but not-enabled. These CPUs can't be brought online
> > until the firmware policy changes, which comes with an ACPI notification
> > that will register the CPUs.
> > 
> > With only the offline and present files, user-space is unable to
> > determine which CPUs it can try to bring online. Add a new CPU mask
> > that shows this based on all the registered CPUs.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > ---
> 
> Needs docs
> Documentation/ABI/testing/sysfs-devices-system-cpu
> seems to have the rest of the similar entries.

Any ideas what I put in there as "Date" ? It seems to me that we have
little idea when this might be merged.. I could use the date of the
commit (Nov 2022).

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

