Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313C13900D6
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 14:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhEYMYB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 08:24:01 -0400
Received: from verein.lst.de ([213.95.11.211]:58920 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232281AbhEYMX6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 08:23:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D8596736F; Tue, 25 May 2021 14:22:24 +0200 (CEST)
Date:   Tue, 25 May 2021 14:22:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, palmerdabbelt@google.com, arnd@arndb.de,
        hch@lst.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>,
        Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] arch: Cleanup unused functions
Message-ID: <20210525122224.GA4474@lst.de>
References: <1621945234-37878-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621945234-37878-1-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 12:20:34PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> These functions haven't been used, so just remove them. The patch
> has been tested with riscv, but I only use grep to check the
> microblaze's.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
