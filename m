Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A5D773B1E
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 17:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjHHPnC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Aug 2023 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjHHPlj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2023 11:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A192110;
        Mon,  7 Aug 2023 20:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9AF2623F2;
        Tue,  8 Aug 2023 03:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3696FC433C8;
        Tue,  8 Aug 2023 03:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691465404;
        bh=zSDhmwKgIhKelnYTgRVV9zIIN7PXUWMhiTRCcrb4LGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsbIqFVPmu413TZ0gFOuGI65PMKM/G5VoBo06r5nhYADaPrk8LnN1YWlHnOCfIEIw
         MersF64VL7CRGcpZys1EnToQ8ofF1J+mDF28YaZpAWjGtGZuL7jT55qJqOXc7XAJrL
         CLI8feqKbuWFMWrQsbOsr5PfUloQeP3MFkCj+R4Bw5jSnjKw0wd5Nt8qTWCdwT1sfJ
         my9VFS0jYb7n4ceMRRm1PA6qjvBUCVhFUuqaxNHq7CwEVhKOek7lrEa3O58TL/rupl
         7om4yNqQtS9jkPEzfLxWpqfvfRSz8W59g5121I3eJY2y5WDkE/FsiKSv+qNaG5tKQN
         qE9KUGs5lip1w==
Date:   Mon, 7 Aug 2023 23:29:56 -0400
From:   Guo Ren <guoren@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>, will@kernel.org
Cc:     David.Laight@aculab.com, guoren@kernel.org, peterz@infradead.org,
        mingo@redhat.com, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2] asm-generic: ticket-lock: Optimize
 arch_spin_value_unlocked
Message-ID: <ZNG2tHFOABSXGCVi@gmail.com>
References: <20230731023308.3748432-1-guoren@kernel.org>
 <20230807183655.kbnjtvbi4jfrcrce@f>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807183655.kbnjtvbi4jfrcrce@f>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 07, 2023 at 08:36:55PM +0200, Mateusz Guzik wrote:
> On Sun, Jul 30, 2023 at 10:33:08PM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > The arch_spin_value_unlocked would cause an unnecessary memory
> > access to the contended value. Although it won't cause a significant
> > performance gap in most architectures, the arch_spin_value_unlocked
> > argument contains enough information. Thus, remove unnecessary
> > atomic_read in arch_spin_value_unlocked().
> > 
> > The caller of arch_spin_value_unlocked() could benefit from this
> > change. Currently, the only caller is lockref.
> > 
> 
> Have you verified you are getting an extra memory access from this in
> lockref? What architecture is it?
For riscv, this patch could optimize the lock_ref on the same compiling
condition:
 - After lifting data dependencies, the compiler optimizes the prologue
   behavior, thus the callee-register-saved path becomes optional. This
   is a significant improvement on the lock_ref() self.
 - Compare the "98: & 9c:" lines before the patch and the "88:" line
   after the patch. We saved two memory accesses not only one load.

========================================================================
Before the patch:
void lockref_get(struct lockref *lockref)
{
  78:   fd010113                add     sp,sp,-48
  7c:   02813023                sd      s0,32(sp)
  80:   02113423                sd      ra,40(sp)
  84:   03010413                add     s0,sp,48

0000000000000088 <.LBB296>:
        CMPXCHG_LOOP(
  88:   00053783                ld      a5,0(a0)

000000000000008c <.LBB265>:
}

static __always_inline int ticket_spin_is_locked(arch_spinlock_t *lock)
{
        u32 val = atomic_read(&lock->val);
        return ((val >> 16) != (val & 0xffff));
  8c:   00010637                lui     a2,0x10

0000000000000090 <.LBE265>:
  90:   06400593                li      a1,100

0000000000000094 <.LBB274>:
  94:   fff60613                add     a2,a2,-1 # ffff <.LLST8+0xf49a>

0000000000000098 <.L8>:
  98:   fef42423                sw      a5,-24(s0)

000000000000009c <.LBB269>:
  9c:   fe842703                lw      a4,-24(s0)

00000000000000a0 <.LBE269>:
  a0:   0107569b                srlw    a3,a4,0x10
  a4:   00c77733                and     a4,a4,a2
  a8:   04e69063                bne     a3,a4,e8 <.L12>

00000000000000ac <.LBB282>:
  ac:   4207d693                sra     a3,a5,0x20
  b0:   02079713                sll     a4,a5,0x20
  b4:   0016869b                addw    a3,a3,1
  b8:   02069693                sll     a3,a3,0x20
  bc:   02075713                srl     a4,a4,0x20
  c0:   00d76733                or      a4,a4,a3

00000000000000c4 <.L0^B1>:
  c4:   100536af                lr.d    a3,(a0)
  c8:   00f69863                bne     a3,a5,d8 <.L1^B1>
  cc:   1ae5382f                sc.d.rl a6,a4,(a0)
  d0:   fe081ae3                bnez    a6,c4 <.L0^B1>
  d4:   0330000f                fence   rw,rw

00000000000000d8 <.L1^B1>:
  d8:   02d78a63                beq     a5,a3,10c <.L7>

00000000000000dc <.LBE292>:
  dc:   fff5859b                addw    a1,a1,-1

00000000000000e0 <.LBB293>:
  e0:   00068793                mv      a5,a3

00000000000000e4 <.LBE293>:
  e4:   fa059ae3                bnez    a1,98 <.L8>

00000000000000e8 <.L12>:

========================================================================
After the patch:
void lockref_get(struct lockref *lockref)
{
        CMPXCHG_LOOP(
  78:   00053783                ld      a5,0(a0)

000000000000007c <.LBB212>:

static __always_inline int ticket_spin_value_unlocked(arch_spinlock_t
lock)
{
        u32 val = lock.val.counter;

        return ((val >> 16) == (val & 0xffff));
  7c:   00010637                lui     a2,0x10

0000000000000080 <.LBE212>:
  80:   06400593                li      a1,100

0000000000000084 <.LBB216>:
  84:   fff60613                add     a2,a2,-1 # ffff <.LLST8+0xf4aa>

0000000000000088 <.L8>:
  88:   0007871b                sext.w  a4,a5

000000000000008c <.LBB217>:
  8c:   0107d69b                srlw    a3,a5,0x10
  90:   00c77733                and     a4,a4,a2
  94:   04e69063                bne     a3,a4,d4 <.L12>

0000000000000098 <.LBB218>:
  98:   4207d693                sra     a3,a5,0x20
  9c:   02079713                sll     a4,a5,0x20
  a0:   0016869b                addw    a3,a3,1
  a4:   02069693                sll     a3,a3,0x20
  a8:   02075713                srl     a4,a4,0x20
  ac:   00d76733                or      a4,a4,a3

00000000000000b0 <.L0^B1>:
  b0:   100536af                lr.d    a3,(a0)
  b4:   00f69863                bne     a3,a5,c4 <.L1^B1>
  b8:   1ae5382f                sc.d.rl a6,a4,(a0)
  bc:   fe081ae3                bnez    a6,b0 <.L0^B1>
  c0:   0330000f                fence   rw,rw

00000000000000c4 <.L1^B1>:
  c4:   04d78a63                beq     a5,a3,118 <.L18>

00000000000000c8 <.LBE228>:
  c8:   fff5859b                addw    a1,a1,-1

00000000000000cc <.LBB229>:
  cc:   00068793                mv      a5,a3

00000000000000d0 <.LBE229>:
  d0:   fa059ce3                bnez    a1,88 <.L8>

00000000000000d4 <.L12>:
{
  d4:   fe010113                add     sp,sp,-32
  d8:   00113c23                sd      ra,24(sp)
  dc:   00813823                sd      s0,16(sp)
  e0:   02010413                add     s0,sp,32
========================================================================

> 
> I have no opinion about the patch itself, I will note though that the
> argument to the routine is *not* the actual memory-shared lockref,
> instead it's something from the local copy obtained with READ_ONCE
> from the real thing. So I would be surprised if the stock routine was
> generating accesses to that sucker.
> 
> Nonetheless, if the patched routine adds nasty asm, that would be nice
> to sort out.
> 
> FWIW on x86-64 qspinlock is used (i.e. not the stuff you are patching)
> and I verified there are only 2 memory accesses -- the initial READ_ONCE
> and later cmpxchg. I don't know which archs *don't* use qspinlock.
> 
> It also turns out generated asm is quite atrocious and cleaning it up
> may yield a small win under more traffic. Maybe I'll see about it later
> this week.
> 
> For example, disassembling lockref_put_return:
> <+0>:     mov    (%rdi),%rax            <-- initial load, expected
> <+3>:     mov    $0x64,%r8d
> <+9>:     mov    %rax,%rdx
> <+12>:    test   %eax,%eax              <-- retries loop back here
> 					<-- this is also the unlocked
> 					    check
> <+14>:    jne    0xffffffff8157aba3 <lockref_put_return+67>
> <+16>:    mov    %rdx,%rsi
> <+19>:    mov    %edx,%edx
> <+21>:    sar    $0x20,%rsi
> <+25>:    lea    -0x1(%rsi),%ecx        <-- new.count--;
> <+28>:    shl    $0x20,%rcx
> <+32>:    or     %rcx,%rdx
> <+35>:    test   %esi,%esi
> <+37>:    jle    0xffffffff8157aba3 <lockref_put_return+67>
> <+39>:    lock cmpxchg %rdx,(%rdi)      <-- the attempt to change
> <+44>:    jne    0xffffffff8157ab9a <lockref_put_return+58>
> <+46>:    shr    $0x20,%rdx
> <+50>:    mov    %rdx,%rax
> <+53>:    jmp    0xffffffff81af8540 <__x86_return_thunk>
> <+58>:    mov    %rax,%rdx
> <+61>:    sub    $0x1,%r8d              <-- retry count check
> <+65>:    jne    0xffffffff8157ab6c <lockref_put_return+12> <-- go back
> <+67>:    mov    $0xffffffff,%eax
> <+72>:    jmp    0xffffffff81af8540 <__x86_return_thunk>
> 
