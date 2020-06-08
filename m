Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29651F198F
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jun 2020 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgFHNBK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Jun 2020 09:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgFHNBJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Jun 2020 09:01:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F4C08C5C2;
        Mon,  8 Jun 2020 06:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qpXUgx7H8PGY1Q+I9yBb43nAQh19YWh36lAL/ZwXSVU=; b=uiyzKjFSiK+9fgV6zvEPw6hizp
        obcMUF0BXowlizp+ziuE7kv4niSSFtACx2GP96MuiWSvHdJHInzUPzTqnolhbqcTBZhaUA2MWA3KE
        DAOxAfBYgQdyfYGjUU3dxIBp24k2w2F/tVhkcg4yHqJRx6kjuL4tAFviMjduajTBaT/SZJCFXQAhI
        1JUxPf1N+abZLCB1VBwtEvyhetJ27soqItScGzQqof4T6tOLZ9GH/cgJ1sHKNv24a0BasdqIWePWH
        I5QCtSiDUF+QrO617kgxUwmc2b1o1hx+bzl3zqLXjSB1AuAsTkPetnj6+oIbyiV0ATxmbtKCJ8i4G
        RfLaHf7Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiHOe-0005FF-6w; Mon, 08 Jun 2020 13:01:00 +0000
Date:   Mon, 8 Jun 2020 06:01:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Rob Landley <rob@landley.net>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] sh: remove unneeded constructor.
Message-ID: <20200608130100.GU19604@bombadil.infradead.org>
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <87600us5k9.wl-ysato@users.sourceforge.jp>
 <20180804103550.GA3183@bombadil.infradead.org>
 <CAMuHMdXsz-+zsxouaLP5tTKA46G34iAACSce+RXrD8AiiQc2+A@mail.gmail.com>
 <20180804105149.GB3183@bombadil.infradead.org>
 <20200606163244.GZ1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200606163244.GZ1079@brightrain.aerifal.cx>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 06, 2020 at 12:32:45PM -0400, Rich Felker wrote:
> On Sat, Aug 04, 2018 at 03:51:49AM -0700, Matthew Wilcox wrote:
> 
> I've been asked to include this in this or next pull request, and I
> think it's right to do so, but I don't have a complete patch from you.
> Can you resubmit with a commit message and signed-off-by?

August 2018?  Things certainly move quickly in SH land ;-)  I'll send
that along.
