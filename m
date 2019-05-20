Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7A23CCA
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2019 18:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbfETQCP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 May 2019 12:02:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387964AbfETQCP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 May 2019 12:02:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E44D88311;
        Mon, 20 May 2019 16:02:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 637F85D6A6;
        Mon, 20 May 2019 16:02:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 20 May 2019 18:02:09 +0200 (CEST)
Date:   Mon, 20 May 2019 18:02:05 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/5] x86: don't use asm-generic/ptrace.h
Message-ID: <20190520160205.GD771@redhat.com>
References: <20190520060018.25569-1-hch@lst.de>
 <20190520060018.25569-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520060018.25569-5-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 20 May 2019 16:02:15 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/20, Christoph Hellwig wrote:
>
> Doing the indirection through macros for the regs accessors just
> makes them harder to read, so implement the helpers directly.

Acked-by: Oleg Nesterov <oleg@redhat.com>

