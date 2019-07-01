Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4F1A3BC
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2019 22:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfEJUKm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 May 2019 16:10:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39450 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfEJUKm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 May 2019 16:10:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so6673136edq.6
        for <linux-arch@vger.kernel.org>; Fri, 10 May 2019 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lt6uPVHRTb6qycTyfS8wkIJ7UlOCcAUHHaR/0rJBxrQ=;
        b=QV72T8OMOUUuvtH5oPeL7SVsQpebI/2757iB7nfbi1QgQeFEOr2Pzznb+d2dTeQJaB
         75txDSZZkqVnX5uQQsVZIGR7r1ncJFMx40HiqBczLATKX+lLzoAyQ1V+YExXXPTkrUaN
         X1M2+twWwnDTuIqBKLxkHrxqOmrDznz1TXYRI9Lc0vSRp6S2FI2NSwJhVeLJM4hzPC8X
         QJhJL217BpKHtcGFYN/Evmo/EX1PKkh85bbGMdRJ93FXIygL7dHcx843s3QZlSHEfmn4
         R+NqS8iRGL49r2mAQfDtJGZi2y12ooafACxZWAizNtF2SobCC1chFXd0fWimueXDK9Gs
         FtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lt6uPVHRTb6qycTyfS8wkIJ7UlOCcAUHHaR/0rJBxrQ=;
        b=jllF9L9ViTnqQyaiTPucdNEiZXyWqpuJRrqsfyTz/BN4XsP/cAg1Pf2Ex8SSUs3Bkh
         MUA52CbCFAL3t2RsMQfrEXKqjEUErkdxcCglmw7OEl9Wv3yHhjmII0eBBFpLqeCC5RiT
         PJ9z6iHjpTwLR426TVqun4MsAoke5pJMTds/9vMrnafF8mQo73AboER7RRtR6vCvLUOO
         MVkKKel2rnFG1rfaK9MVjHFdGtYzXqW8V0eKNZFVNj1qs0+ZmwXf9/hMgjYiX+HMkLSJ
         V3FBqzaYNT7M2niVvCrLW6B9LxGqDla0wbBoOs1MrQsgiuD6gSt4uPNQGS86PhGUDiiG
         +eTw==
X-Gm-Message-State: APjAAAW+aJPXABSwC9ntGifL5DS10x09u4tNVsPXB5JNhwbkFo2BNiXF
        DAqcFflJKvxKmdkrDQ2mms8c4w==
X-Google-Smtp-Source: APXvYqzUgNqtgrYldPEctqQFjJcqlqIpZBpRrpOZjmBasE/wUyTEH0k9GdgYn5cen2XiV7pz/Q0joQ==
X-Received: by 2002:a50:982f:: with SMTP id g44mr13613170edb.278.1557519040152;
        Fri, 10 May 2019 13:10:40 -0700 (PDT)
Received: from google.com ([2a00:79e0:1b:201:ee0a:cce3:df40:3ac5])
        by smtp.gmail.com with ESMTPSA id k37sm1719073edb.11.2019.05.10.13.10.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 13:10:38 -0700 (PDT)
Date:   Fri, 10 May 2019 22:10:32 +0200
From:   Jann Horn <jannh@google.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
Message-ID: <20190510201032.GA253532@google.com>
References: <20190506165439.9155-1-cyphar@cyphar.com>
 <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <87o94d6aql.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o94d6aql.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 07, 2019 at 07:38:58PM -0500, Eric W. Biederman wrote:
> Jann Horn <jannh@google.com> writes:
> > In my opinion, CVE-2019-5736 points out two different problems:
> >
> > The big problem: The __ptrace_may_access() logic has a special-case
> > short-circuit for "introspection" that you can't opt out of;
> 
> Once upon a time in a galaxy far far away I fixed a bug where we missing
> ptrace_may_access checks on various proc files and systems using selinux
> stopped working.  At the time selinux did not allow ptrace like access
> to yourself.  The "introspection" special case was the quick and simple
> work-around.
> 
> There is nothing fundamental in having the "introspection" special case
> except that various lsms have probably grown to depend upon it being
> there.  I expect without difficulty we could move the check down
> into the various lsms.  Which would get that check out of the core
> kernel code.

Oh, if that's an option, that would be great, I think.


But this means, for example, that a non-root, non-dumpable process can't
open /proc/self/maps anymore, or open /proc/self/fd/*, and things like
that, without making itself dumpable. I would be surprised if there is
no code out there that relies on that.

From what I can tell, without the introspection special case,
introspection would fail in the following cases (assuming that the
process is not capable and isn't using sys_setfs[ug]id()):

 - ruid/euid/suid are not all the same
 - rgid/egid/sgid are not all the same
 - process is not dumpable

I think that there probably should be some way for a non-dumpable
process to look at its own procfs entries? If we could start from a
clean slate, I'd propose an opt-in flag to openat() for that, but
since we don't have a clean slate, I'd be afraid of breaking things
with that. But maybe I'm just being overly careful here?
