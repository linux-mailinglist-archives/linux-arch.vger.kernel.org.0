Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA2028003E
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 15:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbgJANgo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbgJANgo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Oct 2020 09:36:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64148C0613D0;
        Thu,  1 Oct 2020 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fKHBx2l1x20GN0S3b+jTfen0uwxhiVfe2eiMSbpdaJc=; b=rkoYrYmb5/6jzedCCWXFLJn1Js
        Su3dhZ5KWDv1MASUxHWIyi0HHPm/ePgWAlqmlPl7vX0YAy66AJdPY+/xm0WAUYoRmEBX+mO+6T8+V
        Icj9pc59qTGH/yoN90T+98J5m6GdmDo4o+YQ6Qcwfvu5StJC1CMj+dZsOTyf/c9HP8WlPBGOb+o0Q
        6D9yVgyZ+6MFyhrDwUasgeNYH4HtwuVAWOPmdotfUbYA/8kLlXOVNla6GYLXq1AzitcCts/t+cL5h
        IEg2Eshs26M+j10DrIY85wx56KguUB9k4rNB/xtXHnDIekBqXSRpUNU87NEPTQuVilHGV1nifj4NB
        bclif4ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNyko-0004ix-3E; Thu, 01 Oct 2020 13:36:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 436ED300446;
        Thu,  1 Oct 2020 15:36:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30D1F203DC1C6; Thu,  1 Oct 2020 15:36:12 +0200 (CEST)
Date:   Thu, 1 Oct 2020 15:36:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
        x86@kernel.org, jthierry@redhat.com, jpoimboe@redhat.com
Subject: Re: [PATCH v4 04/29] objtool: Add a pass for generating __mcount_loc
Message-ID: <20201001133612.GQ2628@hirez.programming.kicks-ass.net>
References: <20200929214631.3516445-1-samitolvanen@google.com>
 <20200929214631.3516445-5-samitolvanen@google.com>
 <alpine.LSU.2.21.2010011504340.6689@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2010011504340.6689@pobox.suse.cz>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 01, 2020 at 03:17:07PM +0200, Miroslav Benes wrote:

> I also wonder about making 'mcount' command separate from 'check'. Similar 
> to what is 'orc' now. But that could be done later.

I'm not convinced more commands make sense. That only begets us the
problem of having to run multiple commands.
