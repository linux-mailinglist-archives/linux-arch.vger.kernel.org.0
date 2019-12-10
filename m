Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B8118B6D
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 15:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfLJOrk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 09:47:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfLJOrk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Dec 2019 09:47:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3581120637;
        Tue, 10 Dec 2019 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575989259;
        bh=t9mW6I2dr+Dg2/7uKgcBKKAq/tKRT4xQ0h18PE3NDVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kb15QnBe5+/0sGZPyfGV8xt6u5BKJLLdRfMUCmYQcSGRu4ORb3O4vWwvAc/HQNWMy
         c13OUy+ybJRy5GsVg1p/JFFwTSvpcNhidAzGa0Nbd8uHjkaH89Td880BBGrk8Vj1j3
         E5rdW5bkfTd3idM8bNpf5rTqvLYbpcqxcWg68C3s=
Date:   Tue, 10 Dec 2019 15:47:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Renninger <trenn@suse.de>
Cc:     Will Deacon <will@kernel.org>,
        Felix Schnizlein <fschnizlein@suse.com>,
        linux-kernel@vger.kernel.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH 3/3] arm64 cpuinfo: implement sysfs nodes for arm64
Message-ID: <20191210144737.GB3975980@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <25032400.G9DUGnJgnc@skinner.arch.suse.de>
 <20191209173804.GD7489@willie-the-truck>
 <11195456.EmMzWPVPDU@skinner.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11195456.EmMzWPVPDU@skinner.arch.suse.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 10, 2019 at 02:33:07PM +0100, Thomas Renninger wrote:
> On Monday, December 9, 2019 6:38:05 PM CET Will Deacon wrote:
> > On Mon, Dec 09, 2019 at 12:28:44PM +0100, Thomas Renninger wrote:
> > > On Monday, December 9, 2019 11:31:11 AM CET Will Deacon wrote:
> > > > On Fri, Dec 06, 2019 at 05:24:21PM +0100, Thomas Renninger wrote:
> > > > > From: Felix Schnizlein <fschnizlein@suse.de>
> > > > > 
> > > > > Export all information from /proc/cpuinfo to sysfs:
> > > > > implementer, architecture, variant, part, revision,
> > > > > bogomips and flags are exported.
> > > > > 
> > > > > Example:
> > > > > /sys/devices/system/cpu/cpu1/info/:[0]# head *
> > > 
> > > ...
> > > 
> > > > > ==> flags <==
> > > > > fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid asimdrdm
> > > 
> > > ...
> > > 
> > > > I don't understand why we need this on arm64
> 
> Again: proc is moving to sys.

No.  New stuff is to be added to /sys/, don't add new things to /proc
unless it deals with processes.

There is no mass-migration of existing /proc files to sysfs for no good
reason.

> You probably export feature flags in /proc/cpuinfo for a good reason.
> So where in sysfs should this show up?

Why does it have to live in sysfs if it is already in /proc and parsed
properly by tools?

thanks,

greg k-h
