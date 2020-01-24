Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0921477A7
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jan 2020 05:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgAXEcM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 23:32:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36162 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAXEcM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 23:32:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id w2so485019pfd.3
        for <linux-arch@vger.kernel.org>; Thu, 23 Jan 2020 20:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :user-agent:mime-version;
        bh=dB6PIC7bEOxOZs3zgfEEHDXJYRlN9x+mhXs0np19giU=;
        b=R5a8BV70MMHo3uYLeeijM9IvNDHVL3LJlGRbhgHeko0jnIpN4twx0BcpH238Hxym4b
         8xdGm1r+vw7roID1mMwq/guElWwQIs/loZBCmDBOhjuRRvhNOAGVnKcc9+Qe6YYq1VJo
         8aN6QmyOqZYPJu3kiVAYGdlVtSEocUGPbO9HifUZ5teCg3yozohgfmNlVl5UTz5CaZVv
         2QE2NwCTN+k9Iy6PYQpagToYoo4SBD8PnJiZBfr/IxovJY7P7Qfs+N2RFD/Og85doKOK
         wqaLuNo0bhRth1m90EW7jSNA4zcqk5jrs8YodTou4p519PePAxDem6HvWkwtqjiVeJYs
         EkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:user-agent:mime-version;
        bh=dB6PIC7bEOxOZs3zgfEEHDXJYRlN9x+mhXs0np19giU=;
        b=XLRVFsoNQTLRRPo1nFdHmqLxIux6prMOyCF1zIwMFjDIXatvNhpUkQg5xCCw5mgAq2
         la+hOkHM2d4xC81A/Fb95r3PImhY0Aj08OqmXeVuYhOFdl6TMVwyZiTjkTjI5DVZUhIE
         iMLbE+c6RiAsp7J8RrIgvV3o05KVgbBZDvin9o7ZwOVKqZzMJuo+MGzV0UMoqJ0XJkhO
         Cz1xRr9TqLZalvLYORL+P51rL74+1u9yrirIOWTtXvrLg+76PqO0T1xmVLijQAnOd7br
         ZY5UsZRHhvx4sJS7BVB4jXHpEK0pRPw5d5timVx/C8cgrUgMLr4HGUwtiiUoybN9mm0m
         tdPA==
X-Gm-Message-State: APjAAAUamb+PqSs6NNIKPPfTzCtgBoYbaO47AdBqOaJrao5beQw3hz0Y
        NQhvP/tzbwXnHmXyd2kAsOo=
X-Google-Smtp-Source: APXvYqy79GWDzkbN0sjK2M5yn4HK4dNJcXrlMR5GqL4odhQsMEqMfJe/yxjHVHEFbvkbDFpQuswBOQ==
X-Received: by 2002:a63:5fce:: with SMTP id t197mr1998123pgb.173.1579840331382;
        Thu, 23 Jan 2020 20:32:11 -0800 (PST)
Received: from earth-mac.local.gmail.com ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id g19sm4070726pfh.134.2020.01.23.20.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 20:32:10 -0800 (PST)
Date:   Fri, 24 Jan 2020 13:32:03 +0900
Message-ID: <m2a76dsce4.wl-thehajime@gmail.com>
From:   Hajime Tazaki <thehajime@gmail.com>
To:     brendanhiggins@google.com
Cc:     kunit-dev@googlegroups.com, tavi.purdila@gmail.com,
        mcgrof@kernel.org, davidgow@google.com, cyphar@cyphar.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        pscollins@google.com, cem@FreeBSD.org, motomuman@gmail.com,
        jiangshanlai@gmail.com, retrage01@gmail.com, petrosagg@gmail.com,
        liuyuan@google.com, thomas@tommie-lie.de, mark@stillwell.me,
        ddiss@suse.de, linux-kernel-library@freelists.org,
        luca.dariz@gmail.com
Subject: Re: [RFC v2 21/37] lkl tools: "boot" test
In-Reply-To: <20200123193315.132434-1-brendanhiggins@google.com>
References: <fb0fcf4ffddaabc7eae82e25d7ec5ea9c37eb2ae.1573179553.git.thehajime@gmail.com>
        <20200123193315.132434-1-brendanhiggins@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/25.3 Mule/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Hello Brendan,

On Fri, 24 Jan 2020 04:33:15 +0900,
Brendan Higgins wrote:

> > +int lkl_test_read(void)
> > +{
> > +	char buf[10] = { 0, };
> > +	long ret;
> > +
> > +	ret = lkl_sys_read(0, buf, sizeof(buf));
> > +
> > +	lkl_test_logf("lkl_sys_read=%ld buf=%s\n", ret, buf);
> > +
> > +	if (ret == sizeof(wrbuf) && !strcmp(wrbuf, buf))
> > +		return TEST_SUCCESS;
> > +
> > +	return TEST_FAILURE;
> > +}
> 
> These tests make me think that LKL could be very useful for KUnit and
> testing syscalls.
> 
> Luis and I had been talking about writing KUnit tests for syscalls to
> validate that syscalls conform to the expected behavior; however,
> calling syscalls from the kernel obviously has issues.
> 
> On the other hand, testing syscalls from a userspace on a booted kernel
> is something that we do and something that needs to be done; however,
> this too has some issues. Writing and running tests in userspace on a
> booted kernel is not as easy as being able to write and run tests in the
> kernel. Also, even though some syscall end-to-end tests are necessary,
> not all syscall tests must be end-to-end tests, especially those which
> are only trying to exercise the entire syscall contract.
> 
> I think it looks like LKL might be able to help us square that circle.

That's good to know :)

> Hajime (and other LKL people):
> 
> What is the current status of this patchset? I have not seen any
> activity for a couple months.

I've been a bit busy over the year-end term but recently restarted to
work for the patchset to address the comments received from the
discussion.

> Luis,
> 
> Does this kind of match what you were thinking with the syscall testing?
> I think this looks pretty close. You should be able to fully test the
> contract here using KUnit. Is there anyone else you think would be
> interested in this?
> 
> In any case, I am excited about this. Please keep me posted in the
> future!

I hope I can send v3 patches soon.
Thanks for the interest !

-- Hajime
