Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3155D228D81
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 03:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgGVBVJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 21:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGVBVJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 21:21:09 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB055C061794;
        Tue, 21 Jul 2020 18:21:08 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A3E5C11E45907;
        Tue, 21 Jul 2020 18:04:23 -0700 (PDT)
Date:   Tue, 21 Jul 2020 18:21:08 -0700 (PDT)
Message-Id: <20200721.182108.566362185204376467.davem@davemloft.net>
To:     viro@ZenIV.linux.org.uk
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 16/18] sparc64: propagate the calling convention
 changes down to __csum_partial_copy_...()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200721202549.4150745-16-viro@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
        <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
        <20200721202549.4150745-16-viro@ZenIV.linux.org.uk>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Jul 2020 18:04:23 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 21 Jul 2020 21:25:47 +0100

> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> ... and rename them into csum_and_copy_...() - the wrappers become pointless.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David S. Miller <davem@davemloft.net>
