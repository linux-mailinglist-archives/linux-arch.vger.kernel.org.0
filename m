Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C997333F72
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2019 09:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfFDHCb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jun 2019 03:02:31 -0400
Received: from verein.lst.de ([213.95.11.211]:33586 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbfFDHCb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jun 2019 03:02:31 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 46D4E68B02; Tue,  4 Jun 2019 09:02:05 +0200 (CEST)
Date:   Tue, 4 Jun 2019 09:02:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove asm-generic/ptrace.h v2
Message-ID: <20190604070205.GA15438@lst.de>
References: <20190520060018.25569-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520060018.25569-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Is anyone going to pick this series up?

On Mon, May 20, 2019 at 08:00:13AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> asm-generic/ptrace.h is a little weird in that it doesn't actually
> implement any functionality, but it provided multiple layers of macros
> that just implement trivial inline functions.  We implement those
> directly in the few architectures and be off with a much simpler
> design.
> 
> Changes since v1:
>  - add a missing empty line between functions
---end quoted text---
