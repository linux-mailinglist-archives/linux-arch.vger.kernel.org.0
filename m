Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A745DA4F
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2019 03:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfGCBIG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Jul 2019 21:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbfGCBIF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Jul 2019 21:08:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B146B21882;
        Tue,  2 Jul 2019 20:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562098756;
        bh=Z0lcfbaVTxOGpZHEzefjuz4P5JZZ+D6oGvvCI6YpnTk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahIgsQXq4LSiIaH4fCEPQ7TpMezx0zGyUMMGD1SZVNq4SRIhD7F0NBXMY0DECRPjw
         yDILof3g6oT5t6GB+plMvXD2bcMS9Q/XmDUd29hLxn0aDB9N2FPc+itt4OvC36g5ZK
         yfa6eGxq+Ip5aB6qhhpNZptfkifguFVREVGb/+dQ=
Date:   Tue, 2 Jul 2019 15:19:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
Message-ID: <20190702201914.GD128603@google.com>
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 23, 2019 at 10:30:42AM +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> As part of my cleanup and consolidation of the PCI resource assignment
> policies, I need to clarify something.
> 
> At the moment, unless PCI_PROBE_ONLY is set, a number of
> platforms/archs expect Linux to reassign everything rather than honor
> what has setup, then (re)assign what's left or broken.

I don't think "reassign everything" is any different from "honor what
has been setup and (re)assign what's left or broken".

"Reassign everything" is clearly allowed to produce the exact same
result as "honor what has been setup and (re)assign what's left or
broken".

I claim any difference between the two is actually a fragile
dependency on the Linux assignment algorithm that is likely to break
as that algorithm changes.

Or am I missing something?

Bjorn
