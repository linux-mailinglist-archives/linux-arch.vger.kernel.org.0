Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DC6652AD
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2019 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfGKHyn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Jul 2019 03:54:43 -0400
Received: from a9-32.smtp-out.amazonses.com ([54.240.9.32]:43830 "EHLO
        a9-32.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727849AbfGKHyn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Jul 2019 03:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1562831682;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=/raghnzRvb/GTCn5s+eX/MH0OP3DJ+YurwG6MlEbgYs=;
        b=S1s804xxXUY5juLFlYYlfbAezptOQ8Mctf3XXVrbJQvH3Hs4Kbfw8gHYyQtPNCVc
        4yMBk5bErvJMP5O7Y4kCKVwGM9fMi5ANqZeQmMMhuc8x6/9fDsLvGd/xIMx6N53vVWI
        r1T3ZLe62J6Q0NDHeTRNIrl33sAZktlvfUfGBGQg=
Date:   Thu, 11 Jul 2019 07:54:42 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Nicholas Piggin <npiggin@gmail.com>
cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [RFC PATCH] mm: remove quicklist page table caches
In-Reply-To: <20190711030339.20892-1-npiggin@gmail.com>
Message-ID: <0100016be006fbda-65d42038-d656-4d74-8b50-9c800afe4f96-000000@email.amazonses.com>
References: <20190711030339.20892-1-npiggin@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.07.11-54.240.9.32
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 11 Jul 2019, Nicholas Piggin wrote:

> Remove page table allocator "quicklists". These have been around for a
> long time, but have not got much traction in the last decade and are
> only used on ia64 and sh architectures.

I also think its good to remove this code. Note sure though if IA64
may still have a need of it. But then its not clear that the IA64 arch is
still in use. Is it still maintained?

> Also it might be better to instead make more general improvements to
> page allocator if this is still so slow.

Well yes many have thought so and made attempts to improve the situation
which generally have failed. But even the fast path of the page allocator
seems to bloat more and more. The situation is deteriorating instead of
getting better and as a result lots of subsystems create their own caches
to avoid the page allocator.

