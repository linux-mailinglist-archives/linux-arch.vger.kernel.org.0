Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9468228D7F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 03:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgGVBVF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 21:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGVBVE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 21:21:04 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3B5C061794;
        Tue, 21 Jul 2020 18:21:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9A6EC11DB315F;
        Tue, 21 Jul 2020 18:04:17 -0700 (PDT)
Date:   Tue, 21 Jul 2020 18:20:59 -0700 (PDT)
Message-Id: <20200721.182059.991648189839997678.davem@davemloft.net>
To:     viro@ZenIV.linux.org.uk
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 11/18] sparc32: propagate the calling conventions
 change down to __csum_partial_copy_sparc_generic()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200721202549.4150745-11-viro@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
        <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
        <20200721202549.4150745-11-viro@ZenIV.linux.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jul 2020 18:04:17 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 21 Jul 2020 21:25:42 +0100

> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> ... and get rid of zeroing the target, etc. on fault.
> All exception handlers merge into one; moreover, since we are not
> calling lookup_fault() anymore, we don't need the magic with passing
> arguments for it from the page fault handler.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David S. Miller <davem@davemloft.net>
