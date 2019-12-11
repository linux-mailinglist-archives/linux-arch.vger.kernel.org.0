Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CECF11AE82
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 15:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfLKO5E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 09:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbfLKO5E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 09:57:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B5CE214AF;
        Wed, 11 Dec 2019 14:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576076223;
        bh=RikKpQKAfx88f9r5aeSm+aYV6wJVq+oyRXyFAH4If2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vwq5ih3Gzc/zeRWqiDWqjjHHUk8T8yWngddwLrn88d+62gc8BLDalBM9Ro3btuvg+
         4BlVNYcEkH/h9G+Z+kqn518qD7kwkTzAfT4s5AjMI64aryGCp1raMfMnM5z3HaFaPw
         oCPkkDQBRXk2gqtcBzJsa9xdEbKWlY12MHqmHlig=
Date:   Wed, 11 Dec 2019 15:57:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Renninger <trenn@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Felix Schnizlein <fschnizlein@suse.com>,
        linux-kernel@vger.kernel.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Message-ID: <20191211145700.GA639677@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <22533595.7ohjOCJ8As@skinner.arch.suse.de>
 <20191211142647.GB605616@kroah.com>
 <2139491.Komy7AgBfX@skinner.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2139491.Komy7AgBfX@skinner.arch.suse.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 03:52:33PM +0100, Thomas Renninger wrote:
> On Wednesday, December 11, 2019 3:26:47 PM CET Greg KH wrote:
> > On Wed, Dec 11, 2019 at 03:12:51PM +0100, Thomas Renninger wrote:
> > > On Wednesday, December 11, 2019 2:56:19 PM CET Greg KH wrote:
> > > > On Wed, Dec 11, 2019 at 11:42:35AM +0100, Thomas Renninger wrote:
> 
> ...
> 
> > > I hope it is agreed that this info is worth exporting via sysfs.
> > 
> > I don't think anyone is saying it is worth exporting this information
> > via sysfs at all here.
> 
> Ok. I go for cpuid userspace tool then.
> 
> I'd still say general files like:
> cpu/info/{name,vendor}
> make sense, so that if exported by an arch like in cpuinfo, it should show up 
> in the same file.
> Every cpu has a model name and a vendor and cpuid is x86 only.

I think you just saw the ARM developers arguing about model names, so I
don't think people will agree with that :)

goo dluck!

greg k-h
