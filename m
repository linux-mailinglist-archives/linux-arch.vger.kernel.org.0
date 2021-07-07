Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CEA3BE827
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jul 2021 14:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhGGMpn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Jul 2021 08:45:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41946 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhGGMpn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jul 2021 08:45:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0D07D223DD;
        Wed,  7 Jul 2021 12:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625661782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7e/V26zjWSQZD4CXv1EiNsTo6/Z5qJ2tHTwoPa+mcvg=;
        b=ZuF0O3JFWlK9/1PLIueOIhY5LpS2HaHUtldnpEObkRncg95v7rIPLnX8FeGZectYtbqDfA
        uxhgxdtZ8ybdLTbXqwHpFpzTziz6kiYy0Q6skdJtIxmM40C2zh51laJ9BlStlDtou85yA2
        e781mqV+jpmkoP0xxVwFPsJeu/QXS4g=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EAF01A3C75;
        Wed,  7 Jul 2021 12:43:00 +0000 (UTC)
Date:   Wed, 7 Jul 2021 14:43:00 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 2/9] kallsyms: Fix address-checks for kernel related range
Message-ID: <YOWhVPvglf6FTZgD@alley>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
 <20210626073439.150586-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626073439.150586-3-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat 2021-06-26 15:34:32, Kefeng Wang wrote:
> The is_kernel_inittext/is_kernel_text/is_kernel function should not
> include the end address(the labels _einittext, _etext and _end) when
> check the address range.

Great catch!

> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Fixes: 04b8eb7a4ccd ("symbol lookup: introduce dereference_symbol_descriptor()")

This commit just moved the code from kernel/kallsyms.c. It was broken
even before the git history ;-)

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
