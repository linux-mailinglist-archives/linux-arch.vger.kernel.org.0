Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119491B2B28
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 17:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgDUPaC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 11:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgDUPaC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2020 11:30:02 -0400
X-Greylist: delayed 45612 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Apr 2020 08:30:02 PDT
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DB5C061A10
        for <linux-arch@vger.kernel.org>; Tue, 21 Apr 2020 08:30:02 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQuqK-007fHW-VB; Tue, 21 Apr 2020 15:29:49 +0000
Date:   Tue, 21 Apr 2020 16:29:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 20/23] fs: Allow copy_mount_options() to access
 user-space in a single pass
Message-ID: <20200421152948.GC23230@ZenIV.linux.org.uk>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-21-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421142603.3894-21-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 03:26:00PM +0100, Catalin Marinas wrote:

> While this function is not on a critical path, the single-pass behaviour
> is required for arm64 MTE (memory tagging) support where a uaccess can
> trigger intra-page faults (tag not matching). With the current
> implementation, if this happens during the first page, the function will
> return -EFAULT.

Details, please.
