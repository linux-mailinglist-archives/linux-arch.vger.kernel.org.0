Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700A03B6BEA
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jun 2021 03:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhF2BIH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 21:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231970AbhF2BIH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Jun 2021 21:08:07 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 144056128A;
        Tue, 29 Jun 2021 01:05:39 +0000 (UTC)
Date:   Mon, 28 Jun 2021 21:05:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3/9] sections: Move and rename core_kernel_data() to
 is_kernel_data()
Message-ID: <20210628210538.0fdded1c@oasis.local.home>
In-Reply-To: <20210626073439.150586-4-wangkefeng.wang@huawei.com>
References: <20210626073439.150586-1-wangkefeng.wang@huawei.com>
        <20210626073439.150586-4-wangkefeng.wang@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 26 Jun 2021 15:34:33 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Move core_kernel_data() into sections.h and rename it to
> is_kernel_data(), also make it return bool value, then
> update all the callers.

Removing the "core" part of "core_kernel_data()" is misleading. As
modules can have kernel data, but this will return false on module data
(as it should). This is similar to core_kernel_text() which this series
doesn't seem to touch.

I'd like to keep the "core" in the name which makes it obvious this is
not about module data, and if someone were to make it about module
data, it will break ftrace synchronization.

-- Steve
