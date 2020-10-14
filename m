Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5315E28E630
	for <lists+linux-arch@lfdr.de>; Wed, 14 Oct 2020 20:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgJNSVs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 14:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgJNSVs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Oct 2020 14:21:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9E4C061755;
        Wed, 14 Oct 2020 11:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4D+6T/0Jyivj7fxKw3DZP3bEv4Hi+6DaIRYNjOGogQc=; b=icPeuHkhwm/7g2D5K7SjNoPM5s
        al/it2gTFcFnA3j1b1bbGIvp9LTWyagOXzUN5jvmI0GDPi6ml4eD0d52R2OwRtyKSvCS+k4demdSu
        VT5KGDheTz5gEsE3WBJE9K02m+nLco4ZktkKbpuxeQdHPW3/i9FtrGhn6R3XCDKJQd/onhJsK73W4
        LKhukfnTNYT9ZUzSX6bJ/yNVJYi9sFnQkAK2Ap4gEoxUpX3920FOVTde0jJ7FAsLgwsBb9awOT8wF
        J2wNgf1SGp7lO6tY4adBbux1qDforNMyg6G3iWIsLIfBozBc0lW3wPEQ/gxl/dF/llRv6F8wwIxxm
        oZgiXiXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSlOq-0004TS-Kg; Wed, 14 Oct 2020 18:21:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 402B0300DAE;
        Wed, 14 Oct 2020 20:21:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23F3520696FD8; Wed, 14 Oct 2020 20:21:15 +0200 (CEST)
Date:   Wed, 14 Oct 2020 20:21:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v6 02/25] objtool: Add a pass for generating __mcount_loc
Message-ID: <20201014182115.GF2594@hirez.programming.kicks-ass.net>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-3-samitolvanen@google.com>
 <20201014165004.GA3593121@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014165004.GA3593121@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 14, 2020 at 06:50:04PM +0200, Ingo Molnar wrote:
> Meh, adding --mcount as an option to 'objtool check' was a valid hack for a 
> prototype patchset, but please turn this into a proper subcommand, just 
> like 'objtool orc' is.
> 
> 'objtool check' should ... keep checking. :-)

No, no subcommands. orc being a subcommand was a mistake.
