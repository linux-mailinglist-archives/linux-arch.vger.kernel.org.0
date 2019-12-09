Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D712117638
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2019 20:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfLITsX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Dec 2019 14:48:23 -0500
Received: from verein.lst.de ([213.95.11.211]:44298 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfLITsX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Dec 2019 14:48:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0C82868BFE; Mon,  9 Dec 2019 20:48:19 +0100 (CET)
Date:   Mon, 9 Dec 2019 20:48:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: RFC: kill off ioremap_nocache
Message-ID: <20191209194819.GA28157@lst.de>
References: <20191209135823.28465-1-hch@lst.de> <CAADWXX9zEBT-NPCwE09D+6=8iCZ+kCmdyXoGrTKhnmYn82XEJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADWXX9zEBT-NPCwE09D+6=8iCZ+kCmdyXoGrTKhnmYn82XEJQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 09, 2019 at 10:48:20AM -0800, Linus Torvalds wrote:
> How many conflicts will this result in generally? I like it, but I'd
> like to have some idea of whether it ends up being one of those
> "really painful churn" things?
> 
> A couple of conflicts isn't an issue - they'll be trivial to fix. It's
> the "this causes fifty silly conflicts" that I worry about, partly
> because it then makes submaintainers inevitably do the wrong thing (ie
> "I foresee an excessive amount of 'git rebase' rants next release").

I had about a dozend and a half conflicts rebasing this weekend,
the previous version was approx -rc6 IIRC.
