Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BA225E14C
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 20:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgIDSGY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 14:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIDSGY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 14:06:24 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2578AC061244;
        Fri,  4 Sep 2020 11:06:24 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEG6L-00ATnC-Uh; Fri, 04 Sep 2020 18:06:18 +0000
Date:   Fri, 4 Sep 2020 19:06:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/8] asm-generic: fix unaligned access hamdling in
 raw_copy_{from,to}_user
Message-ID: <20200904180617.GQ1236603@ZenIV.linux.org.uk>
References: <20200904165216.1799796-1-hch@lst.de>
 <20200904165216.1799796-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904165216.1799796-4-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 04, 2020 at 06:52:11PM +0200, Christoph Hellwig wrote:
> Use get_unaligned and put_unaligned for the small constant size cases
> in the generic uaccess routines.  This ensures they can be used for
> architectures that do not support unaligned loads and stores, while
> being a no-op for those that do.

Frankly, I would rather get rid of those constant-sized cases entirely;
sure, we'd need to adjust asm-generic/uaccess.h defaults for __get_user(),
but there that kind of stuff would make sense; in raw_copy_from_user()
it really doesn't.
