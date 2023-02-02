Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6364C68882C
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 21:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjBBUUN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 15:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjBBUUM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 15:20:12 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EC66A7B;
        Thu,  2 Feb 2023 12:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JqYAryr4ncgoLGfd4SoGpnz0Btqk8njgp0CFfJJoxYc=; b=ahQdNdoWXNamq8v8GUJXd1cvzs
        bh1QAw2pLpwbgpIkiW4MXAENtYwxA8evdkZ0OHQdhbv785v4kNRqy1WgvLwiSdL2OV13ronn+7d2s
        aght84mc5KaTnWTTx66d3O463syBC9hnW2ENJDYA+7kkHEjRkjRsycbEVYnq8KKwgJPfAR5NewgAp
        LoyOLYSuAIy5OL+iS8gEUrRlwDNoHFhRW+WCFkfyO3w1hJHnPntPNZ3aAsqVlZFw48bqHf9BxD+1F
        SxZdFqZ54EJ3sljftXHys6Zc67Qf/ks1/Qc8Mfe8/U7jPydeBhrXQygMTNdOUydBfWvM3RRbGFd/g
        ofHg7UoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pNg3v-005m5N-1o;
        Thu, 02 Feb 2023 20:20:03 +0000
Date:   Thu, 2 Feb 2023 20:20:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Michael Cree <mcree@orcon.net.nz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC][PATCHSET] VM_FAULT_RETRY fixes
Message-ID: <Y9wa8zWWec00vGWa@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <CAHk-=whf73Vm2U3jyTva95ihZzefQbThZZxqZuKAF-Xjwq=G4Q@mail.gmail.com>
 <Y9mD1qp/6zm+jOME@ZenIV>
 <CAHk-=wjiwFzEGd_60H3nbgVB=R_8KTcfUJmXy=hSXCvLrXQRFA@mail.gmail.com>
 <Y9te+4n4ajSF++Ex@ZenIV>
 <Y9t6Swqt+A9noVIf@creeky>
 <Y9vUxXEHRb07bh3J@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9vUxXEHRb07bh3J@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 02, 2023 at 03:20:37PM +0000, Al Viro wrote:

> "Racy" probably had been about something along the lines of the scenario
> I'd mentioned just upthread, but in 5.5 that "racy" escalated to "does not
> work at all" - if you ever hit a vmalloc-related fault, you are going
> to get an oops.  You still get 8Gb, but beyond that it's broken.
> 
> And it's almost certainly not the problem you are seeing...

Incidentally, direct store to pgd_val() in there looks fishy wrt barriers -
shouldn't there be an smp_wmb() before we shove that sucker into our
top-level table's entry?
