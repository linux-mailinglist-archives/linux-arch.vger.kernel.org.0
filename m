Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025A772CB71
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 18:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjFLQ0H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 12:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjFLQ0G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 12:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A0CF9
        for <linux-arch@vger.kernel.org>; Mon, 12 Jun 2023 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686587123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EqwXplhA6elh/wvBFScazI5+BTtK4bRNV6UTAcVMSLo=;
        b=UuDbwnEFrZBtfztTcQTYm7kGuLXEoq5H+ccZRYjcZBorpM5sSaJBrT254HJmR/pjvvQaS6
        Aq0XH6p5FbAnl+DWyoAtDFzTnw0oNGROXLaluJLeHoG/6VcWEefue/aeqxZqL0SXgDItvg
        YleaMGOLf4zU1bsIMWmN8D3/94QMi/8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-NIRQjG4DO2iVouFJ8HAEYA-1; Mon, 12 Jun 2023 12:25:22 -0400
X-MC-Unique: NIRQjG4DO2iVouFJ8HAEYA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b2b00c5ee0so211848a34.0
        for <linux-arch@vger.kernel.org>; Mon, 12 Jun 2023 09:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587121; x=1689179121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqwXplhA6elh/wvBFScazI5+BTtK4bRNV6UTAcVMSLo=;
        b=XqvU4+jRY120GPpU4TtfmuPXJD0ed6QIU6buvmibFVJpBNSu1xw8245pOBhc5FwPGw
         pIYe/6aiu5exuh96NP5FpduSEgAwD39Z032/DCVkJfWU7uaTZ2oeGLyRH8x0ksdnH2Vl
         lwE51CFIPYx7S9y9Z1Irbtk3tk5pXN1jJLZyds4UzLvbL7h9ul3meZ1v2k2NDA5VcNO8
         guUocjWWsu0Z4/U61vmu9Ptjx9O5nFgb/TBW5xuWn1dxNslAMPLlHmWkOXQwVej1QWfU
         LUsq1I0kA4QDEp1QL+VVaWpPmW2emRkCRRUHkha604YGCifQ+jWLuEHixhhru2suPVZm
         n9Aw==
X-Gm-Message-State: AC+VfDwKuThSJdBiW2biF520ulZGi1RVPljyZn23PqyNFRPlVvEMMMhZ
        hLxyMtZnZaqke6ZUSnTb6Z8XJd+3GAgJCneRmhF4o4E8hjSKaASTPKBujYEykxIJtnerRrQhErI
        P7Y6BtYwsUm7Pziz+HXTBLw==
X-Received: by 2002:a05:6830:6116:b0:6b1:5075:87ec with SMTP id ca22-20020a056830611600b006b1507587ecmr5481288otb.1.1686587121461;
        Mon, 12 Jun 2023 09:25:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6oDPJ4lumFhl21SxU7udUxydSD4vf4JJO9yBFnkI9xGni4BGh7usWoNwiiWtsG9588r15Cdw==
X-Received: by 2002:a05:6830:6116:b0:6b1:5075:87ec with SMTP id ca22-20020a056830611600b006b1507587ecmr5481276otb.1.1686587121169;
        Mon, 12 Jun 2023 09:25:21 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id j3-20020a0cf303000000b00627a6fd04ddsm3313829qvl.122.2023.06.12.09.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:25:20 -0700 (PDT)
Date:   Mon, 12 Jun 2023 12:25:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        mike.kravetz@oracle.com, andreyknvl@gmail.com,
        dave.hansen@intel.com, luto@kernel.org, brauner@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
Subject: Re: [PATCH RFC v2 0/4]  Add support for sharing page tables across
 processes (Previously mshare)
Message-ID: <ZIdG7rMDY6649hSp@x1n>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682453344.git.khalid.aziz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 26, 2023 at 10:49:47AM -0600, Khalid Aziz wrote:
> This patch series adds a new flag to mmap() call - MAP_SHARED_PT.

Since hugetlb has this, it'll be very helpful if you can provide a
comparison between this approach and hugetlb's - especially on the
differences - and reasonings about those.

Merging anything like this definitely should also pave way for hugetlb's
future, so it even seems to be an "requirement" of such patchset even
though implicitily..  considering the "hotness" that hugetlb recently has
on refactoring demand (if not a rewrite).

Some high level questions:

  - Why mmap() flag?

    For this one, I agree it should be opt-in - sharing pgtable definitely
    means sharing of a lot of privileges operating on current mm, so one
    should be aware and be prepared to be messed up.

    IIUC hugetlb doesn't do this but instead when something "racy" happens
    itt just unshares by default.  To me opt-in makes more sense if to
    start from zero, because I don't think by default a process wants to
    leak its mm to others.

    I think you mentioned allowing pgtable to be shared even for mprotect()
    from one MM then all MMs can see; but if so then DONTNEED should really
    do the same - when one MM DONTNEED it it should go away for all.  It
    doesn't make a lot of sense to me to treat it differently with a
    DONTNEED refcount anywhere..

  - Can guest MM opt-out?

    Should we allow guest MM to opt-out when they want?  It sounds like a
    good thing to have to me, especially for file that sounds like as
    simple as zapping the pgtable.  But then mmap flag will stop working
    iiuc, so goes back to that question (e.g. what about madvise or prctl?).

  - Why mm_struct to represent shared pgtable?

    IIUC hugetlb used the pgtable page itself plus some refcounting (the
    refcounting is racy with gup-fast that Jann used to point out, but
    that's another story..).  My question is do you think that won't work?
    Are there reasons to explain?  Why mm_struct is the structure you chose
    for representing a shared pgtable?  Why per-file?

Thanks,

-- 
Peter Xu

