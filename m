Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5CA366E70
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 16:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhDUOsq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhDUOsq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Apr 2021 10:48:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E398BC06174A;
        Wed, 21 Apr 2021 07:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mUy7Z7Cqh/kpdpcln7GhfH2MItHWFJPtzojsUV4j4c0=; b=cRrCrwJ4naR+YdPEfib6N7bw+s
        MwOM7BRfTeEHbRtin6uWlv1oMsDCWSC9KnTbTwbDk0uuxphIAXycIbGGcjEG78gHZ0lsu/wLYY19Y
        A+Cw915I9TWZ3ceu/p2qQAd7rGoX/PQv6b/e4et/GvjYd7JcfwlzSz+cI4L7huejAzM5GbLBytNEO
        jfVblwf0jEEibnLLeimNariGUtm7Zrb4JY75GSbsNXhXHwfyPktk+xtzf3AfbpNirDgsBfFDHayZp
        ygKqI1tfLGBAeGC+NmStmiec296tFN0hutr3RBveRTMOhL6EHn6q/1gd5znbBCDRmh40kWvREB4uh
        577NK8sQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZE96-00Geqc-UG; Wed, 21 Apr 2021 14:48:05 +0000
Date:   Wed, 21 Apr 2021 15:48:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] csky: uaccess.h: Coding convention with asm generic
Message-ID: <20210421144804.GA3969416@infradead.org>
References: <1618995255-91499-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618995255-91499-1-git-send-email-guoren@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 21, 2021 at 08:54:15AM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Using asm-generic/uaccess.h to prevent duplicated code:
>  - Add user_addr_max which mentioned in generic uaccess.h
>  - Remove custom definitions of KERNEL/USER_DS, get/set_fs,
>    uaccess_kerenl

Instead of using the generic definitions removing support for set_fs
entirely would be much preferred.  The series in linux-next for mips,
or the riscv version that landed in 5.10 might be good examples.
