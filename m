Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B3443682B
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 18:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhJUQnj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhJUQnM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 12:43:12 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE27C061220
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:40:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q5so819435pgr.7
        for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2021 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1yAbubDNqKerRe4y8n0JI5rsGyf/bW80kr1c+8k/81E=;
        b=MTSHGYJn62+WzjKWUs0N8qnmPtyM9Aduew+ywV94ky56Xc0OO2DZlJM4ePaNxYSBt+
         JizjjueLRQahHWgHGibtKHzD3LEZroL5qQO+NiCGgdskzPNmcrjU84TNP8cXFrEjgwjR
         bL897TtegwfovNjAB4omVryquyxkl5ka6qrIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1yAbubDNqKerRe4y8n0JI5rsGyf/bW80kr1c+8k/81E=;
        b=MEajChXt0FmPN1MV1wUJ/sJp77iuXBkzRlWb9a+64L0FrLUqXvStrxtP/2iZu81Pou
         yhURl88/MBmMTBhR8yaZcbhe7VQUVTR5zqlukuyU16+trePsF/O9WbVKVgx+Z5hYq6YD
         2MVgIicT0qyeFW7PMN9+FW6EP/lqtdH3noLCIC9WczLGxb3sHBlHnHz/3LgyMPjqG6XJ
         xA1lSHMS3w7mhCmpotfPTHsOgSHKd+2b/0KJiFKrdfGIAciECvekMlfpOT607b7DeJ9/
         +u+UpspZqWahXOKilqDm99aHv6RA09h6LnG34N5yx4UX3AWr68fUVNlXPDbo8h73ptgb
         IdWQ==
X-Gm-Message-State: AOAM531BUBag25cwSGT0qpclfsZha0nvNKeG+2grTq2iSrl9vSoVdtSS
        YAOObmqAkCith1ciDG4SWX+0LA==
X-Google-Smtp-Source: ABdhPJxRAMcJ4IumOPIRoJHUAntSMMzpKJ28SMBh5ZhpCz83M1s0OlNbMcjlmbEMRRWNniwraaPyWQ==
X-Received: by 2002:a05:6a00:cd6:b0:471:aded:3884 with SMTP id b22-20020a056a000cd600b00471aded3884mr3756534pfv.18.1634834454415;
        Thu, 21 Oct 2021 09:40:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k2sm6730143pfu.80.2021.10.21.09.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:40:54 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:40:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 14/20] exit/syscall_user_dispatch: Send ordinary signals
 on failure
Message-ID: <202110210940.3BBA18AA@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-14-ebiederm@xmission.com>
 <202110210925.9DEAF27CA@keescook>
 <878rymbags.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rymbags.fsf@disp2133>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 21, 2021 at 11:37:23AM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Wed, Oct 20, 2021 at 12:44:00PM -0500, Eric W. Biederman wrote:
> >> Use force_fatal_sig instead of calling do_exit directly.  This ensures
> >> the ordinary signal handling path gets invoked, core dumps as
> >> appropriate get created, and for multi-threaded processes all of the
> >> threads are terminated not just a single thread.
> >
> > Yeah, looks good. Should be no visible behavior change.
> 
> It is observable in that an entire multi-threaded process gets
> terminated instead of a single thread.  But since these events should
> be handling of extra-ordinary events I don't expect there is anyone
> who wants to have a thread of their process survive.

Right -- sorry, I should have said that more clearly: "Besides the
single thread death now taking the whole process, there's not behavior
change (i.e. the signal delivery)." Still looks good to me.

-- 
Kees Cook
