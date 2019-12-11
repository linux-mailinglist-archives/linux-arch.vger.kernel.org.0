Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD511BBCA
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 19:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfLKSeM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 13:34:12 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:29366 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbfLKSeM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:34:12 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id xBBIO1oW032484;
        Wed, 11 Dec 2019 19:24:01 +0100
Date:   Wed, 11 Dec 2019 19:24:01 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        dan.carpenter@oracle.com, will@kernel.org, ebiederm@xmission.com,
        linux-arch@vger.kernel.org, security@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] execve: warn if process starts with executable stack
Message-ID: <20191211182401.GF31670@1wt.eu>
References: <20191208171918.GC19716@avx2>
 <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
 <20191211072225.GB3700@avx2>
 <20191211095937.GB31670@1wt.eu>
 <20191211181933.GA3919@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211181933.GA3919@avx2>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 09:19:33PM +0300, Alexey Dobriyan wrote:
> Reports are better be done by people who know what they are doing, as in
> understand what executable stack is and what does it mean in reality.
> 
> > Otherwise it will just go to /dev/null with all warning about bad blocks
> > on USB sticks and CPU core throttling under high temperature.
> 
> That's fine. You don't want bugreports from people who don't know what
> is executable stack. Every security bug bounty program is flooded by
> such people. This is why message is worded in a neutral way.

Well we definitely don't have the same experience with user reports. I
was just suggesting, but since you apparently already have all the
responses you needed, I'm even wondering why the warning remains.

Willy
