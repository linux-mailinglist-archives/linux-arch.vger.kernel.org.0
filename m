Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5101A3FFA0A
	for <lists+linux-arch@lfdr.de>; Fri,  3 Sep 2021 07:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhICF4c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Sep 2021 01:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233766AbhICF4c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Sep 2021 01:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630648532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVcqIhLjK1aLZFmGstA8aMe5xkC0R7kiAZwq3yD/UZo=;
        b=MZDF97QFhjJS8ErjA7NEtJpZOYG0jzgBTtJjf4MEDi55LTYWJm0NQkO8zD2hI9ZdvbV8B7
        JdHMU8OKf5FMjXsOSdZ10gmY8EG6i+BXXJ4jYYKvpdv1+2/KRDnnyn+e91EI+9MAVzNfU1
        2ui5sEzDugw9iOOwYwwydq+C0Enj1UA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-hugSUXQXOoGwmxF73q8VHA-1; Fri, 03 Sep 2021 01:55:31 -0400
X-MC-Unique: hugSUXQXOoGwmxF73q8VHA-1
Received: by mail-qt1-f198.google.com with SMTP id e3-20020ac80b030000b029028ac1c46c2aso4502558qti.2
        for <linux-arch@vger.kernel.org>; Thu, 02 Sep 2021 22:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YVcqIhLjK1aLZFmGstA8aMe5xkC0R7kiAZwq3yD/UZo=;
        b=oZ/bvpCix9GwUYXt376BSutagfWC7JgcmlMWnN9a4oK76yH9YniN+0s9todKzkVqLA
         UCiEb/3gnSkvhgnHoLQlCMGRcZcdIVOJIYdAwOcyI9fUqvluxY0ERdyvBPoppqjQNGvZ
         EgFh2b8rLPZkjJupzpLZNgmxbfIpRFrJ5EjEipKN/Bk4H1CcqVIkvvtyZY5faKJKROv/
         Y5esFVbdqfe26SBassTnyyyb6/GA8vX0z3j3AF3Fm5yMlaqlD2Db9uBf4R6mQx5k7BTQ
         xLTqp0yV7zfCX60huMQsGgevOYEJs2sZS1Sn4XFX0htrzE/IBdsyvbmWesnQDvytL8HY
         DchA==
X-Gm-Message-State: AOAM5311Qsz8RPu6OBN6bZ+THQSun/v50Gk4/a+SMnIYNxUg9COuIch2
        O75vopZVMdziMxmKsnafy5S8QGJHCRTsSshXxc9WpZYd5q2U9/4uYkWUXHqQHpJQ6IxSiEU1YzU
        czgWJr1SVEoVRnj8nXqh5Vw==
X-Received: by 2002:a05:620a:1529:: with SMTP id n9mr1829202qkk.322.1630648530598;
        Thu, 02 Sep 2021 22:55:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBA2PPgx2ogxp7sl4eBWoxXxd8xybtAdlH2aAWqzoyoFquWEXA675Jbr2q0U4tlJxGlHbFOw==
X-Received: by 2002:a05:620a:1529:: with SMTP id n9mr1829187qkk.322.1630648530395;
        Thu, 02 Sep 2021 22:55:30 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id g8sm3144077qkm.25.2021.09.02.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 22:55:29 -0700 (PDT)
Date:   Thu, 2 Sep 2021 22:55:26 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/4] vmlinux.lds.h: Use regular *RODATA and
 *RO_AFTER_INIT_DATA suffixes
Message-ID: <20210903055526.mmi6hoomawavkbsp@treble>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901233757.2571878-2-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 01, 2021 at 04:37:54PM -0700, Kees Cook wrote:
> Rename the various section macros that live in RODATA and
> RO_AFTER_INIT_DATA. Just being called "DATA" implies they are expected
> to be writable.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

