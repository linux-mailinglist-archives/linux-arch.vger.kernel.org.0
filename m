Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8890828F9EB
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 22:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbgJOUKR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 16:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388919AbgJOUKR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Oct 2020 16:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602792615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSZZdQFYiEF1TvfexFPRAVhe3w/8OtEerqz5dRK9QXg=;
        b=Bq4WPG2kaLIR4kk9GJJ4JBxw+XX5grZ3bV4dLUCVT5qp9UxOX/jnD8NbjK/Okm4qfZtaGq
        iA1J/CrjsYcQCfArvGbQ3gJb/V+4QOYms12j00s80fXvVRVAqjqLHYAemZ73LidRT/6Xra
        F6oTXfCXRUl9KSUix3wwn1zTuMHyxUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-te9p4b8XOfue84xzeHLT6w-1; Thu, 15 Oct 2020 16:10:10 -0400
X-MC-Unique: te9p4b8XOfue84xzeHLT6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59D8A803651;
        Thu, 15 Oct 2020 20:10:07 +0000 (UTC)
Received: from treble (ovpn-115-218.rdu2.redhat.com [10.10.115.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 233035C1BB;
        Thu, 15 Oct 2020 20:10:02 +0000 (UTC)
Date:   Thu, 15 Oct 2020 15:10:00 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
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
        x86@kernel.org
Subject: Re: [PATCH v6 02/25] objtool: Add a pass for generating __mcount_loc
Message-ID: <20201015201000.poiepgn5fssnogtf@treble>
References: <20201013003203.4168817-1-samitolvanen@google.com>
 <20201013003203.4168817-3-samitolvanen@google.com>
 <20201014165004.GA3593121@gmail.com>
 <20201014182115.GF2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201014182115.GF2594@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 14, 2020 at 08:21:15PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 14, 2020 at 06:50:04PM +0200, Ingo Molnar wrote:
> > Meh, adding --mcount as an option to 'objtool check' was a valid hack for a 
> > prototype patchset, but please turn this into a proper subcommand, just 
> > like 'objtool orc' is.
> > 
> > 'objtool check' should ... keep checking. :-)
> 
> No, no subcommands. orc being a subcommand was a mistake.

Yup, it gets real awkward when trying to combine subcommands.

I proposed a more logical design:

  https://lkml.kernel.org/r/20201002141303.hyl72to37wudoi66@treble

-- 
Josh

