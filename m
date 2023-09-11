Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B5579BAAA
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 02:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjIKVE6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243645AbjIKR1R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 13:27:17 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E3B125;
        Mon, 11 Sep 2023 10:27:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6FB9E5C0165;
        Mon, 11 Sep 2023 13:27:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 11 Sep 2023 13:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694453228; x=1694539628; bh=Td
        Gi7kVXEnEKoxN/ecGUPAlNClbuxU0h+eeQmE5muyU=; b=TPU3W6SYFJ7e/IDmmJ
        xVpTiH4yGa4dS7/hYvgGW+IxFjo1AKWnWi0cxY73TQNDRBy95nX+2Ln16B8eX+uc
        24420CK6I+1E3po3N/7w6h+xpUVQN5iakEs9SWqkGZzfaBWyS8mm6ZZcXDNM3Enj
        DNcD+XPFH3/ihBtnnceAmRyohx2HuIkc5x0O3q3+DSBnjvcY+BkG+Ar6jfpTCZaC
        MYz7GqU4CJ57CeyBG8ba0NMZMAqq9xuJb2lsZMjLUDlR55FsghaGUcXNfPHXYiMW
        7BvR9RFZY0ARIWsZzZ1y0E+Ff1fiyeCC4tzrg5BS0lbP2yUy2A2/Za+2QGm0oS9a
        Sg+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694453228; x=1694539628; bh=TdGi7kVXEnEKo
        xN/ecGUPAlNClbuxU0h+eeQmE5muyU=; b=IjBdVEQ0w4QnMwyv3KzHbk003lgrX
        CryomNEZLcLZtWdU9qgXMjkgPVvkDx0seprWJ02+laI36Kw20IGYJqHv9LDinrGQ
        JBNearY/wXoxxZXuVopKdKzhu95lW9UDS2VBu/3UjrRHzRAWm2ZtFC2p9pA78atd
        ialY5pN3M6gfMqfiGa5aAVs3etQoeHcj3+V+JvcPNB61AakLSWOO+CZt7G2pzoln
        zF3O891DCL6ZY5tksw8iHqFr2maJLJzUSVak2EOiqAow0PSq/nj7BFYQlROoMtlX
        ErBVjE/jeBLlJzqURyFTJd2ImY+ltCXPj09M1PRQ2td2j4mbPC1MAzZoA==
X-ME-Sender: <xms:6U3_ZDAItsKohJrpOX0uEMEkEAxzm3QjJajwzyjZxdmAKPDrYWEDaA>
    <xme:6U3_ZJi4Eudh4S8_7fjb7Yj_G8MTc8o7F7iYINwrkvR1lyqcfR2cuFcM0w4Sw7BtA
    NNurCDYAE0hbrSo_0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeigedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6U3_ZOmAUShIz1HnYgmzBw2dyATGVeic8h1uMbmqjso3L3Sxe_HTOw>
    <xmx:6U3_ZFylNI6c-B9sY4q6WZvBrRULVLHGeYUgy0FbbXzxh2U1dsV-LQ>
    <xmx:6U3_ZITUDk4-y_jscr0qL5-f3PPv0XhwOAR7JoqXM3SVOFVH9MXQ3w>
    <xmx:7E3_ZPLrOvvJLlcwP2woMLT2bK_I5P4HhJeKDGBmxqXR4N-uSRzmNg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C5A3EB60089; Mon, 11 Sep 2023 13:27:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <e80f9c6f-d194-41c7-bdb5-e6a78751f543@app.fastmail.com>
In-Reply-To: <ZP28D8dZXz3+4s9v@memverge.com>
References: <20230907075453.350554-1-gregory.price@memverge.com>
 <20230907075453.350554-4-gregory.price@memverge.com>
 <f73d0495-f575-4b97-bc74-a57bd427df98@app.fastmail.com>
 <ZPrRcJCjRBvJ9c3N@memverge.com>
 <2fe03345-01a2-4cfe-9648-ae088493d1af@app.fastmail.com>
 <ZP28D8dZXz3+4s9v@memverge.com>
Date:   Mon, 11 Sep 2023 19:26:45 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Gregory Price" <gregory.price@memverge.com>
Cc:     "Gregory Price" <gourry.memverge@gmail.com>,
        linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andrew Morton" <akpm@linux-foundation.org>, x86@kernel.org
Subject: Re: [RFC PATCH 3/3] mm/migrate: Create move_phys_pages syscall
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 10, 2023, at 14:52, Gregory Price wrote:
> On Sat, Sep 09, 2023 at 05:18:13PM +0200, Arnd Bergmann wrote:
>> 
>> I think a pointer to '__u64' is the most appropriate here,
>> that is compatible between 32-bit and 64-bit architectures
>> and covers all addresses until we get architectures with
>> 128-bit addressing.
>> 
>> Thinking about it more, I noticed an existing bug in
>> both sys_move_pages and your current version of
>> sys_move_phys_pages: the 'pages' array is in fact not
>> suitable for compat tasks and needs an is_compat_task
>> check to load a 32-bit address from compat userspace on
>> the "if (get_user(p, pages + i))" line.
>>
>
> I'll clean up the current implementation for what I have on a v2 of an
> RFC, and then look at adding some pull-ahead patches to fix both
> move_pages and move_phys_pages for compat processes.  Might take me a
> bit, I've only done compat work once before and I remember it being
> annoying to get right.

I think what you want is roughly this (untested):

--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2159,6 +2159,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
                         const int __user *nodes,
                         int __user *status, int flags)
 {
+       struct compat_uptr_t __user *compat_pages = (void __user *)pages;
        int current_node = NUMA_NO_NODE;
        LIST_HEAD(pagelist);
        int start, i;
@@ -2171,8 +2172,17 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
                int node;
 
                err = -EFAULT;
-               if (get_user(p, pages + i))
-                       goto out_flush;
+               if (in_compat_syscall() {
+                       compat_uptr_t cp;
+
+                       if (get_user(cp, compat_pages + i))
+                               goto out_flush;
+
+                       p = compat_ptr(cp);
+               } else {
+                       if (get_user(p, pages + i))
+                               goto out_flush;
+               }
                if (get_user(node, nodes + i))
                        goto out_flush;
 
alternatively you could use the get_compat_pages_array()
helper that is already used in the do_pages_stat()
function.

> I did see other work on migrate.c hanging around on the list, I'll
> double check this hasn't already been discovered/handled.

It looks like I broke it, and it was working before my own
5b1b561ba73c8 ("mm: simplify compat_sys_move_pages"), which
only handled the nodes=NULL path.

I suppose nobody noticed the regression because there are very
few 32-bit NUMA systems, and even fewer cases in which one
would run compat userspace to manage a 64-bit NUMA machine.

>
> This only requires plumbing new 2 flags through do_pages_move, and no
> new user-exposed types or information.
>
> Is there an ick-factor with the idea of adding the following?
>
> MPOL_MF_PHYS_ADDR : Treat page migration addresses as physical
> MPOL_MF_PFN : Treat page migration addresses as PFNs

I would strongly prefer supporting only one of the two, and
a 64-bit physical address seems like the logical choice here.

>> These do not seem to be problematic from the ASLR perspective, so
>> I guess it may still be useful without CAP_SYS_ADMIN.
>
> After reviewing the capabilities documentation it seems like
> CAP_SYS_NICE is the appropriate capability.  My last meassage I said
> CAP_SYS_ADMIN was probably correct, but I think using CAP_SYS_NICE
> is more appropriate unless there are strong feelings due to the use of
> PFN and Physcall Address.
>
> I'm not sure rowhammer is of great concern in this interface because you
> can't choose the destination address, only the destination node. Though
> I suppose someone could go nuts and try to "massage" a node in some way
> to get a statistical likelihood of placement (similar heap grooming).

I agree that this doesn't introduce any additional risk for rowhammer
attacks, but it seems slightly more logical to me to use CAP_SYS_ADMIN
if that is what the other interfaces use that handle physical addresses
and may leak address information.

     Arnd
