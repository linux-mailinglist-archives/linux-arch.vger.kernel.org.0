Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0152745
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfFYI4t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 04:56:49 -0400
Received: from verein.lst.de ([213.95.11.211]:32847 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730944AbfFYI4t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 04:56:49 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1CC2868B02; Tue, 25 Jun 2019 10:56:17 +0200 (CEST)
Date:   Tue, 25 Jun 2019 10:56:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] remove arch/sh?
Message-ID: <20190625085616.GA32399@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus and maintainers,

arch/sh seems pretty much unmaintained these days.  The last time I got
any reply to sh patches from the list maintainers, and the last maintainer
pull request was over a year ago, and even that has been rather sporadic.

In the meantime we've not really seen any updates for new kernel features
and code seems to be bitrotting.
