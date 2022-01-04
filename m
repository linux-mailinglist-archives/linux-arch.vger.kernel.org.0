Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D32348402F
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 11:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiADKzF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 05:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiADKzE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 05:55:04 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F87C061761;
        Tue,  4 Jan 2022 02:55:03 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id o6so146935710edc.4;
        Tue, 04 Jan 2022 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qo7MfwZ/KvNpjLuX0AalrXe+EU3+SzyKgCuKC89+8c4=;
        b=NGf/rKn9vWkj9qozFbjNNnV9j8eC5rUkcfuD4uGJDZTi9EqIfyGQuCAZCYLYvxVL+j
         D2XUKIigcbnlF/ZKD+jiSVhcHFBI8UZHQFa1qduTLTiF6EaXlzvSp0I08OJ0ETEyscLd
         52/EC5pTEdMYdgWP9VhkQLY7IzkZAjX1Cqe5uguNw9pjSz2aREyrAJxpJBiWOaOjbDcY
         hxifUQ08qcvxlQiX6YbynLvQ3h6ZjYsLaZLoGrS8f1IxySJqzqcyXaZFkGQOGjWC7Ki7
         eoURmLyD2eqLANp3k7uKQrXSRZ2Y7ybAZZTSKM4mtHN/tf8Gp5YJKh4+1GUGNcMVkr2d
         OKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qo7MfwZ/KvNpjLuX0AalrXe+EU3+SzyKgCuKC89+8c4=;
        b=KlwgPfqrbTQGGn2pDEhuuOpQH8M/feyHvHxt9MQzaBkYsNyYXqxwddm2HS86yeFmnO
         8wzu6eEDQF/MqeKBq3i2NKVwQGoScQ11u26WFd17WmjCicTXcSXepwO7/YAj3hOY1C23
         JZZphviQFHvTT6uk7YwWCpc5FitRMT6YqEM7x2UJxXb94FOGvdqxCA4tlCYs12eRgCIi
         HCSXURjV7sf7NPgi4Tut28YnAMhl/i7sifwMQEdHv6qfOX3abajwd92wKLe8MLlKJgPc
         +hdfgWoVSuyEIWyiAGQFcq2z0hyCsRU9r+tj+Q2sUnWB2aM3rtkuf8pR24kuFLZDIsWO
         wokQ==
X-Gm-Message-State: AOAM531CdXhQt7BdA88VUhdZrX8lccG7bhXDV/nRnjR1EEP79pV+Lz3A
        Yv0+FEFdne5h8jaxDgApnGY=
X-Google-Smtp-Source: ABdhPJxtKN50K9MstX41PEfhh5ZqKvj5aiuYqdpWjdJYc1a2wJqYiP0rHn00NPsG5lTBuORZ7H6LJw==
X-Received: by 2002:a17:907:7050:: with SMTP id ws16mr39068192ejb.153.1641293702510;
        Tue, 04 Jan 2022 02:55:02 -0800 (PST)
Received: from gmail.com (0526F11B.dsl.pool.telekom.hu. [5.38.241.27])
        by smtp.gmail.com with ESMTPSA id x20sm12864682edd.28.2022.01.04.02.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 02:55:02 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 4 Jan 2022 11:54:55 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdQnfyD0JzkGIzEN@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <20220103135400.4p5ezn3ntgpefuan@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103135400.4p5ezn3ntgpefuan@box.shutemov.name>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

\
* Kirill A. Shutemov <kirill@shutemov.name> wrote:

> On Sun, Jan 02, 2022 at 10:57:35PM +0100, Ingo Molnar wrote:
> >  - As to testing & runtime behavior: while all of these patches are 
> >    intended to be bug-free, I did find a couple of semi-bugs in the kernel 
> >    where a specific order of headers guaranteed a particular code 
> >    generation outcome - and if that header order was disturbed, the kernel 
> >    would silently break and fail to boot ...
> 
> Looks like you are doing a lot of uninlining. Do you see any runtime
> performance degradation with the patchset?

I haven't tested that yet - and it's pretty hard to performance test 
uninlining patches directly.

But what I've done is that I basically looked at the context and tried to 
make a judgement call based on generated code.

In all the uninlining patches where I thought it might not be clear whether 
it's proper to uninline I added detailed analysis, such as this one:

  commit d94530f1abcbfd2500e90e151e7c67ff48ab3259
  Author: Ingo Molnar <mingo@kernel.org>
  Date:   Sat Nov 20 18:20:58 2021 +0100

    headers/uninline: Uninline multi-use function: put_page()
    
    Ever since the page_is_devmap_managed() logic was added to put_page() in:
    
      07d802699528: ("mm: devmap: refactor 1-based refcounting for ZONE_DEVICE pages")
    
    put_page() has become a much larger function of over 2 dozen instructions:

    0000000000004d30 <put_page>:
        4d30:       e8 00 00 00 00          call   4d35 <put_page+0x5>
        4d35:       55                      push   %rbp
        4d36:       48 8b 47 08             mov    0x8(%rdi),%rax
        4d3a:       48 8d 50 ff             lea    -0x1(%rax),%rdx
        4d3e:       a8 01                   test   $0x1,%al
        4d40:       48 89 e5                mov    %rsp,%rbp
        4d43:       48 0f 45 fa             cmovne %rdx,%rdi
        4d47:       66 90                   xchg   %ax,%ax
        4d49:       f0 ff 4f 34             lock decl 0x34(%rdi)
        4d4d:       74 27                   je     4d76 <put_page+0x46>
        4d4f:       5d                      pop    %rbp
        4d50:       c3                      ret
        4d51:       48 8b 07                mov    (%rdi),%rax
        4d54:       48 c1 e8 33             shr    $0x33,%rax
        4d58:       83 e0 07                and    $0x7,%eax
        4d5b:       83 f8 04                cmp    $0x4,%eax
        4d5e:       75 e9                   jne    4d49 <put_page+0x19>
        4d60:       48 8b 47 08             mov    0x8(%rdi),%rax
        4d64:       8b 40 68                mov    0x68(%rax),%eax
        4d67:       83 e8 01                sub    $0x1,%eax
        4d6a:       83 f8 01                cmp    $0x1,%eax
        4d6d:       77 da                   ja     4d49 <put_page+0x19>
        4d6f:       e8 00 00 00 00          call   4d74 <put_page+0x44>
        4d74:       5d                      pop    %rbp
        4d75:       c3                      ret
        4d76:       e8 00 00 00 00          call   4d7b <put_page+0x4b>
        4d7b:       5d                      pop    %rbp
        4d7c:       c3                      ret
    
    Uninline it.
    
    To counter some of the runtime overhead of the extra function call,
    inline the __put_page() instance into put_page() - this is now
    possible without extra bloat.
    
    There's a measurable improvement in vmlinux text size, on a distro
    kernel build, by ~4 KB.
    
    Doing so also decouples <linux/mm_api.h> from <linux/memremap.h>.
    
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

I think it's pretty much a given that we don't want to inline 2 dozen 
instructions for every put_page() call and we don't need performance 
testing.

Admittedly my 'judgement call' was colored by the overall goal to decouple 
types and headers, so please do double check! None of the uninlining 
patches are critical to this tree - there's various other ways headers can 
be decoupled other than uninlining.

There's one happy exception though, all the uninlining patches that 
uninline a single-call function are probably fine as-is:

 ef1028c44345 headers/uninline: Uninline single-use function: mips: page_size_ftlb()
 98bc89e85e3f headers/uninline: Uninline single-use function: set_page_links()
 e368b54381e9 headers/uninline: Uninline single-use function: cpupid_to_nid()
 36b59978a96d headers/uninline: Uninline single-use function: wb_domain_size_changed()
 4c95e8f21924 headers/uninline: Uninline single-use function: skb_metadata_differs()
 28195c3f7eba headers/uninline: Uninline single-use function: for_each_netdev_feature()
 3c82b720eb01 headers/uninline: Uninline single-use function: SPI_STATISTICS_ADD_*()
 e7c48e440df3 headers/uninline: Uninline single-use function: qdisc_run()
 ba0bfe18c8cc headers/uninline: Uninline single-use function: dev_validate_header()
 3443e75fd1f8 headers/uninline: Uninline single-use function: kobject_has_children()
 0e15d2fb85f9 headers/uninline: Uninline single-use function: xfrm_dev_state_free()
 45d5233e1f5f headers/uninline: Uninline single-use function: flow_dissector_init_keys()
 7a897b0747b2 headers/uninline: Uninline single-use function: reqsk_alloc()
 f9003f1bd834 headers/uninline: Uninline single-use function: skb_propagate_pfmemalloc()
 54ea5750f484 headers/uninline: Uninline single-use function: syscall_tracepoint_update()
 5a1dc0bca4a4 headers/uninline: Uninline single-use function: proc_sys_poll_event()
 0af72df4042d headers/uninline: Uninline single-use function: ep_take_care_of_epollwakeup()
 13a8bd09a93a headers/uninline: Uninline single-use function: ptrace_event_pid()
 f2b8980d4178 headers/uninline: Uninline single-use function: itimerspec64_valid()
 ec111205e6de headers/uninline: Uninline single-use function: sk_under_cgroup_hierarchy()
 d623ba9eb252 headers/uninline: Uninline single-use function: wb_find_current() and wb_get_create_current()

Thanks,

	Ingo
