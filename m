Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBE425D40B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgIDIzx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 04:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729917AbgIDIzw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 04:55:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45671C061244;
        Fri,  4 Sep 2020 01:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Ph7JbkbFaoWfq28ICsly/8XMu67nEPXs5Q9waIv3f0=; b=O1Wk6g+4dtnT/2kNHdruUhmJV+
        6tEB67TeIbdL+Al5Jn9XY44q6y9lQhurDBfwdtD2w6dxjzl4spbONnX1/Kj3RoZoEDodS0yfasFX3
        S372OJaKBTzpshK5Q6gZ9YlJP2cFOminq4D2m+ZPqghHqvMXLsI91kT1ZAkbUfWdAN1cu2Xo6TgZo
        eoX51+rzTdO5E3cpEnC8uolXotY9q3+nOJCI6AFCcAomERKJIfcW+E1EPFb91rQnk5qLy7cBbUWLq
        O2t8c7qjE6mzHu4WL0RtNjIoZu8mDkM3XCINb38ZwjrOvS+cuffk7p1QSoG9LtYeG+sRoXJxwGWXG
        qZeWJzEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE7VD-0003wl-6w; Fri, 04 Sep 2020 08:55:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95E99300F7A;
        Fri,  4 Sep 2020 10:55:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A4B12BBB68A3; Fri,  4 Sep 2020 10:55:20 +0200 (CEST)
Date:   Fri, 4 Sep 2020 10:55:20 +0200
From:   peterz@infradead.org
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 00/28] Add support for Clang LTO
Message-ID: <20200904085520.GN2674@hirez.programming.kicks-ass.net>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Please don't nest series!

Start a new thread for every posting.
