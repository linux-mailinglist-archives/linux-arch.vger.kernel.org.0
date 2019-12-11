Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B9811AC8D
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 14:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfLKN42 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 08:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbfLKN42 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 08:56:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC557214D8;
        Wed, 11 Dec 2019 13:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576072588;
        bh=dWkqILqfAhjEvyhCKPXISYgfOfSC3OtngOei9pUlZ5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=enaEjm3qhz+GbI1C7GZdbjUVp+Li+O9XxQqiaGueU8xTWyFJi3xOAs08wqOcxr99A
         TjmdjHoIohXmbLhvAqKCb708/vwcxCf5WQ+UYx2BMRwMzocjhZQpyBHCi1+hTg2dJV
         4lSTU4jvrB9a4wmcTqpHvJGg5DZ7YKEwkIIzpHRU=
Date:   Wed, 11 Dec 2019 14:56:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Renninger <trenn@suse.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Felix Schnizlein <fschnizlein@suse.com>,
        linux-kernel@vger.kernel.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Message-ID: <20191211135619.GA538980@kroah.com>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206163656.GC86904@kroah.com>
 <87sglroqix.fsf@nanos.tec.linutronix.de>
 <4737004.4U1sY2OxSp@skinner.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4737004.4U1sY2OxSp@skinner.arch.suse.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 11:42:35AM +0100, Thomas Renninger wrote:
> If Greg (and others) are ok, I would add "page size exceeding" handling.
> Hm, quick searching for an example I realize that debugfs can exceed page 
> size. Is it that hard to expose a sysfs file larger than page size?

No, there is a simple way to do it, but I'm not going to show you how as
it is NOT how to use sysfs at all :)

Why are you wanting to dump this whole mess into one file and then parse
it, it's no different from having 100+ different sysfs files and then
doing a readdir(3) on the thing, right?

greg k-h
