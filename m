Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122B02814C1
	for <lists+linux-arch@lfdr.de>; Fri,  2 Oct 2020 16:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbgJBONY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Oct 2020 10:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbgJBONX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Oct 2020 10:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601648002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T8R1XgQI7k4cK5q1LMAze0lbj0we9wkSuLhijnQjdY4=;
        b=b+3b8K7u2drGN0KmGLzAYxNJ9Ag53zLPy+A1ccgWOLpNj2EpMwsOdYLGu+AAdIfoRy886u
        FAp6EM6ol6Unj1vQc9VDi8iL5QbmJewK+21Hcp2FbUrKZoojTTpWaSO8ZL2kgkNfIGSnO+
        6f3YN28IozZPhIQJNxuMN77TVkH/dcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-KaOFE74rOgejG5g4BEKn6g-1; Fri, 02 Oct 2020 10:13:18 -0400
X-MC-Unique: KaOFE74rOgejG5g4BEKn6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C952801ADA;
        Fri,  2 Oct 2020 14:13:16 +0000 (UTC)
Received: from treble (ovpn-114-202.rdu2.redhat.com [10.10.114.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3550E81C5B;
        Fri,  2 Oct 2020 14:13:07 +0000 (UTC)
Date:   Fri, 2 Oct 2020 09:13:03 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Sami Tolvanen <samitolvanen@google.com>,
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
        x86@kernel.org, jthierry@redhat.com
Subject: Re: [PATCH v4 04/29] objtool: Add a pass for generating __mcount_loc
Message-ID: <20201002141303.hyl72to37wudoi66@treble>
References: <20200929214631.3516445-1-samitolvanen@google.com>
 <20200929214631.3516445-5-samitolvanen@google.com>
 <alpine.LSU.2.21.2010011504340.6689@pobox.suse.cz>
 <20201001133612.GQ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201001133612.GQ2628@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 01, 2020 at 03:36:12PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 01, 2020 at 03:17:07PM +0200, Miroslav Benes wrote:
> 
> > I also wonder about making 'mcount' command separate from 'check'. Similar 
> > to what is 'orc' now. But that could be done later.
> 
> I'm not convinced more commands make sense. That only begets us the
> problem of having to run multiple commands.

Agreed, it gets hairy when we need to combine things.  I think "orc" as
a separate subcommand was a mistake.

We should change to something like

  objtool run [--check] [--orc] [--mcount]
  objtool dump [--orc] [--mcount]

-- 
Josh

