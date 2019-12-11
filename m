Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810BB11AD66
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 15:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfLKO0u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 09:26:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbfLKO0u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 09:26:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E5C420836;
        Wed, 11 Dec 2019 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576074409;
        bh=Qy1znBU3pH+6omj0HjeyroPBVpb9rQjYap7r0jfAG98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjvxOVhSQ707fRbeqTGUXDcuhEnzOxXEY+NxteZ5p9aSm+qeQJSaibiL5kHCZ33sd
         Pd/bmPcoPYFx8uiwXjWgkfnXB0s+RY7apIIL5HJMwzItLR0FHncehO7FSui0mBdjxG
         r17SLeJRPEidTZ+Eih0GExSsMWMovYmsTKbTBCog=
Date:   Wed, 11 Dec 2019 15:26:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Renninger <trenn@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Felix Schnizlein <fschnizlein@suse.com>,
        linux-kernel@vger.kernel.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Message-ID: <20191211142647.GB605616@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <4737004.4U1sY2OxSp@skinner.arch.suse.de>
 <20191211135619.GA538980@kroah.com>
 <22533595.7ohjOCJ8As@skinner.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22533595.7ohjOCJ8As@skinner.arch.suse.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 03:12:51PM +0100, Thomas Renninger wrote:
> On Wednesday, December 11, 2019 2:56:19 PM CET Greg KH wrote:
> > On Wed, Dec 11, 2019 at 11:42:35AM +0100, Thomas Renninger wrote:
> > > If Greg (and others) are ok, I would add "page size exceeding" handling.
> > > Hm, quick searching for an example I realize that debugfs can exceed page
> > > size. Is it that hard to expose a sysfs file larger than page size?
> > 
> > No, there is a simple way to do it, but I'm not going to show you how as
> > it is NOT how to use sysfs at all :)
> >
> > Why are you wanting to dump this whole mess into one file
> 
> I wouldn't call a whitespace separated list of CPU feature flags a mess...

It's a mess in that it's more than one value and you want to overflow a
PAGE_SIZE sometime in the future with it :(

> > and then parse
> > it, it's no different from having 100+ different sysfs files and then
> > doing a readdir(3) on the thing, right?
> 
> If this is the way it "has to"/should/"is designed for" to export such
> (not that complex) data via sysfs...
> 
> I do not have such a strong opinion on the how, this is up to maintainers
> to discuss.
> 
> I hope it is agreed that this info is worth exporting via sysfs.

I don't think anyone is saying it is worth exporting this information
via sysfs at all here.

thanks,

greg k-h
