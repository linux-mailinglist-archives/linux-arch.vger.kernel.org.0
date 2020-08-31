Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881172583F5
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 00:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgHaWPL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Aug 2020 18:15:11 -0400
Received: from ms.lwn.net ([45.79.88.28]:39018 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHaWPL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Aug 2020 18:15:11 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A51992D5;
        Mon, 31 Aug 2020 22:15:10 +0000 (UTC)
Date:   Mon, 31 Aug 2020 16:15:09 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v2 0/3] docs/memory-barriers: Apply missed changes
Message-ID: <20200831161509.43016cf4@lwn.net>
In-Reply-To: <20200829082607.3146-1-sj38.park@gmail.com>
References: <20200829082607.3146-1-sj38.park@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 29 Aug 2020 10:26:04 +0200
SeongJae Park <sj38.park@gmail.com> wrote:

> This patchset applies missed changes that should land in the
> memory-barriers.txt and its Korean translation.
> 
> The patches are based on v5.9-rc2.
> 
> Changes from v1
>  - Fix mismatch between author and Signed-off-by:
> 
> SeongJae Park (3):
>   docs/memory-barriers.txt: Fix references for DMA*.txt files
>   docs/memory-barriers.txt/kokr: Remove remaining references to mmiowb()
>   dics/memory-barriers.txt/kokr: Allow architecture to override the
>     flush barrier
> 
>  Documentation/memory-barriers.txt             |  8 ++---
>  .../translations/ko_KR/memory-barriers.txt    | 32 ++++++++++++-------
>  2 files changed, 24 insertions(+), 16 deletions(-)

I've applied the set, thanks.

jon
