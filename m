Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067F617648F
	for <lists+linux-arch@lfdr.de>; Mon,  2 Mar 2020 21:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgCBUDn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Mar 2020 15:03:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39929 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBUDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 15:03:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so219870plp.6;
        Mon, 02 Mar 2020 12:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8hnni3vhDi7aIbQYbHQMlr5ZqUcPLomGxoatdX8mrA=;
        b=G4F3ABfL+nSKdHhvHaQ8a/dXmq7YCuP27SmEv3R68C1b/0fWQwHUbpQsHRMlKMGHnM
         Gv/xqaKL1W36ksFG0c3KV5ClumQoKaPQ+DT4NHrJS8uum2Nd6iUsLUpLIwq9nYi0q4zF
         vi9gR3DYY9doPCxMlBxuKWJZvF5+/Rc6aLu5nlfgal1P/LPcOEbvTkUCCpWfO81sRnYT
         M7Bo5ydXuch8tvmGlrC1xLCDDYcIUiq+Il4RiIvEXaPr1Cw4hqWzMUYyOfLuMS4iuk6o
         Wh8qfCzUD0cJe6YP6leq2S0QJAMWxMNChdFnNwvm7LByjHc10CRJHd15D18pZDjWQrPy
         54PQ==
X-Gm-Message-State: ANhLgQ2fAD82FCPA15IElk1a7E4RpuuAOwHNAAdyjSx+eGTvxNFqQQV7
        CeObhdZODRXh1AHr7jowd7A=
X-Google-Smtp-Source: ADFU+vuYB7JzcPlCMm+BX7Ut7SC8WjNgfZ7Q/iUBFudLCFG4YiiLGj8tYwOu7drenEZPr/9oGb9n4g==
X-Received: by 2002:a17:902:ba94:: with SMTP id k20mr776029pls.104.1583179420392;
        Mon, 02 Mar 2020 12:03:40 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e9sm70268pjt.16.2020.03.02.12.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:03:38 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D3240413C3; Mon,  2 Mar 2020 20:03:37 +0000 (UTC)
Date:   Mon, 2 Mar 2020 20:03:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
Message-ID: <20200302200337.GH11244@42.do-not-panic.com>
References: <20200228012036.15682-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228012036.15682-1-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Guenter,

are you still running your cross-architecture tests? If so any chance
you can try this for your build tests?

Brendan, do you have this code in a branch which can be merged into
linux-next by any chance?

  Luis
