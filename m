Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191BD25811F
	for <lists+linux-arch@lfdr.de>; Mon, 31 Aug 2020 20:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgHaScl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 14:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbgHaScl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 14:32:41 -0400
Received: from X1 (unknown [65.49.58.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9D32068E;
        Mon, 31 Aug 2020 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598898761;
        bh=IJWqZYiEAgu6edR7LUZp0oV9domNNjSkxvSunR2fNlY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gdPtafFq042MKMz9tTXZSnpsHiYRrVAePxsYjzVvAD7AHLeDpt/M0XxKJ9BP2kXJr
         CCvOoo//ZMOIWncG96EmcImuxOr/91W41xKcKhDpRE6gB9xwuJpKtrnYHuWGmsUv3K
         nEnCrZcPAuSM8C70lfdbJyuEKbTsiuG+dmPgxiQI=
Date:   Mon, 31 Aug 2020 11:32:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     albert.linde@gmail.com
Cc:     bp@alien8.de, mingo@redhat.com, corbet@lwn.net, tglx@linutronix.de,
        arnd@arndb.de, peterz@infradead.org, akinobu.mita@gmail.com,
        hpa@zytor.com, viro@zeniv.linux.org.uk, glider@google.com,
        andreyknvl@google.com, dvyukov@google.com, elver@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Albert van der Linde <alinde@google.com>
Subject: Re: [PATCH v3 0/3] add fault injection to user memory access
Message-Id: <20200831113238.b6b38076bb02076458592a3d@linux-foundation.org>
In-Reply-To: <20200831171733.955393-1-alinde@google.com>
References: <20200831171733.955393-1-alinde@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 31 Aug 2020 17:17:30 +0000 albert.linde@gmail.com wrote:

> The goal of this series is to improve testing of fault-tolerance in
> usages of user memory access functions, by adding support for fault
> injection.

Does anyone actually plan to use this feature, on an ongoing basis? 
It's the sort of thing which the various test robots could exploit, but
I'm not sure that they are using fault injection?
