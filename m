Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2989588991
	for <lists+linux-arch@lfdr.de>; Wed,  3 Aug 2022 11:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiHCJmZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Aug 2022 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiHCJmY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Aug 2022 05:42:24 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE771CB11
        for <linux-arch@vger.kernel.org>; Wed,  3 Aug 2022 02:42:23 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 123so27520895ybv.7
        for <linux-arch@vger.kernel.org>; Wed, 03 Aug 2022 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/5J/hTicAQKvIdTCsN8vIr3eGdVqz6oWNgR8PbCUFZ0=;
        b=UW16xIvrWocqAhSPd2fuZKeM91zaflQgPYWDJgcud8Cri8Ym2URa03dCI1zYrFIezW
         fICUhA0MZ7uec2/HuZSKY8g8uGB5q9N7Au4XQr5K6FFHmZ0hO8ktztxtkSHEE/vb6IJn
         KEbgA906UOjZ2Rsii9K4/vyPRuud1tCOtgEnGKmFhWYZsrm+DJlhbb1l0W8029yPcEw/
         8c52Bmse7AJhuI4irdCL1QGGKXLNRBxfMKaBMuCSsl1oJGfOPZbVh8tpZKDkfDCUULtN
         JQPCee3tCjakxMT3yWiBiUPIVoXDmFby7RIPPsTaDJd+7IqvhfoTZn6FAP+2a7YrsBk5
         gNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/5J/hTicAQKvIdTCsN8vIr3eGdVqz6oWNgR8PbCUFZ0=;
        b=UwE7fAqdNcajwDsIN0MeC484SSn6e+q4XDfeF/MFGesOzrPiBr/9e9cTSuHG8DqYb4
         PvJV64aoNe0fosFYkjQb7i2hUDF4vjvkrezAc/+O+ZYZy2/c/wam6bgv/7Tnshz90/9t
         ePbGQ0COZi8euFJt5h4ZSJrpmcixw/IKB46tAyK6Mt0jkmnNeAkHghpx/U46v2XPFRoe
         Yw94LBE4sFz7KtLljM5tkW4B61eJxSUvO3yUojzA1XQ955lTcVHhupx5WtGk3CBLtRyb
         AMDB9j/tO0zmk+QaR2Gd459NZlQuHY2KvzD3Hn3rhMzg68LEDviDIWc1U6xWNo1my289
         BWpQ==
X-Gm-Message-State: ACgBeo2tDfFnyWALHePbWlHZ6sXdpJ2lGySmH5ZXAMsDM0L2NjegRTb0
        poE0QQGeiYAxE8Imw3OsXvKDlN6XVpPDO/1nepuzkg==
X-Google-Smtp-Source: AA6agR7WMDXiL70b6NLngI/XHKFbP2/r+w7WmXN1qYL7/w1ywK0n4OfWAmZKsLbnW7QxKw6oUWpd6k7KLsAW0q+NLBo=
X-Received: by 2002:a25:d7d3:0:b0:671:899b:eafc with SMTP id
 o202-20020a25d7d3000000b00671899beafcmr18510665ybg.485.1659519742790; Wed, 03
 Aug 2022 02:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-11-glider@google.com>
 <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
In-Reply-To: <CANpmjNOYqXSw5+Sxt0+=oOUQ1iQKVtEYHv20=sh_9nywxXUyWw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 3 Aug 2022 11:41:46 +0200
Message-ID: <CAG_fn=UToPvi8-1puuCS95o1V36MkAwFyQKFgp0AxBROcNgfKg@mail.gmail.com>
Subject: Re: [PATCH v4 10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
To:     Marco Elver <elver@google.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(+ Dan Williams)

On Mon, Jul 11, 2022 at 6:27 PM Marco Elver <elver@google.com> wrote:
>
> On Fri, 1 Jul 2022 at 16:23, Alexander Potapenko <glider@google.com> wrote:
> >
> > KMSAN adds extra metadata fields to struct page, so it does not fit into
> > 64 bytes anymore.
>
> Does this somehow cause extra space being used in all kernel configs?
> If not, it would be good to note this in the commit message.

I actually couldn't verify this on QEMU, because the driver never got loaded.
Looks like this increases the amount of memory used by the nvdimm
driver in all kernel configs that enable it (including those that
don't use KMSAN), but I am not sure how much is that.

Dan, do you know how bad increasing MAX_STRUCT_PAGE_SIZE can be?

>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
