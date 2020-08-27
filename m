Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D03254A49
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgH0QN6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Aug 2020 12:13:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:38021 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0QN5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Aug 2020 12:13:57 -0400
IronPort-SDR: i1tw97kLHH4gkMnMpwPvpZqvFyOD8j1123jHxH01azdtVBV8AFVN+w8+IwcNU6cl7jDZH9iMdD
 iOd3K3+JftEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="220767054"
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="gz'50?scan'50,208,50";a="220767054"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP; 27 Aug 2020 09:13:38 -0700
IronPort-SDR: 0wKPZZkD3f2pcyIP/odalPZy9W37M2A56QvwsbTVzwOh2y2w9Zr4dIK6PQQNsynl7c+GsSqoej
 UlQxK7N2qZkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="gz'50?scan'50,208,50";a="329642700"
Received: from lkp-server01.sh.intel.com (HELO 4f455964fc6c) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2020 09:13:35 -0700
Received: from kbuild by 4f455964fc6c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kBKWt-00029q-1d; Thu, 27 Aug 2020 16:13:35 +0000
Date:   Fri, 28 Aug 2020 00:13:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chunguang Xu <brookxu.cn@gmail.com>, arnd@arndb.de
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        rppt@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/23] jfs: use ASSERT_FAIL()/ASSERT_WARN() to cleanup
 some code
Message-ID: <202008280030.lrR2wXqO%lkp@intel.com>
References: <9797d150e126542889c4a8c0601f997a8199e900.1598518912.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <9797d150e126542889c4a8c0601f997a8199e900.1598518912.git.brookxu@tencent.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chunguang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on scsi/for-next block/for-next linus/master asm-generic/master v5.9-rc2 next-20200827]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chunguang-Xu/clean-up-the-code-related-to-ASSERT/20200827-182148
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
config: x86_64-randconfig-a014-20200827 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 71f3169e1baeff262583b35ef88f8fb6df7be85e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/jfs/namei.c:524:3: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                   assert(!test_cflag(COMMIT_Nolink, ip));
                   ^
   fs/jfs/namei.c:640:3: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                   assert(filetype != S_IFDIR);
                   ^
   fs/jfs/namei.c:1191:4: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                           assert(!test_cflag(COMMIT_Nolink, new_ip));
                           ^
   3 errors generated.
--
>> fs/jfs/jfs_xtree.c:494:3: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                   BT_PUSH(btstack, bn, index);
                   ^
   fs/jfs/jfs_btree.h:119:2: note: expanded from macro 'BT_PUSH'
           assert(!BT_STACK_FULL(BTSTACK));\
           ^
   fs/jfs/jfs_xtree.c:3180:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(flag != COMMIT_PMAP);
           ^
   fs/jfs/jfs_xtree.c:3843:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           BT_PUSH(&btstack, bn, index);
           ^
   fs/jfs/jfs_btree.h:119:2: note: expanded from macro 'BT_PUSH'
           assert(!BT_STACK_FULL(BTSTACK));\
           ^
   3 errors generated.
--
>> fs/jfs/jfs_imap.c:679:3: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                   assert(tlck->type & tlckXTREE);
                   ^
   fs/jfs/jfs_imap.c:1095:4: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                           assert(ciagp != NULL);
                           ^
   fs/jfs/jfs_imap.c:1109:4: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                           assert(diagp != NULL);
                           ^
   fs/jfs/jfs_imap.c:1428:6: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                                           assert(rc == -EIO);
                                           ^
   fs/jfs/jfs_imap.c:1511:6: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                                           assert(rc == -EIO);
                                           ^
   fs/jfs/jfs_imap.c:1550:6: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                                           assert(rc == -EIO);
                                           ^
   fs/jfs/jfs_imap.c:2689:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(start < 32);
           ^
   fs/jfs/jfs_imap.c:2813:3: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                   assert(mp->clsn);
                   ^
   8 errors generated.
--
>> fs/jfs/jfs_dmap.c:700:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(nblocks > 0);
           ^
   fs/jfs/jfs_dmap.c:1865:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert((blkno & (BPERDMAP - 1)) == 0);
           ^
   fs/jfs/jfs_dmap.c:1991:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(l2nb <= L2BPERDMAP);
           ^
   fs/jfs/jfs_dmap.c:2182:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(dbitno + nblocks <= BPERDMAP);
           ^
   fs/jfs/jfs_dmap.c:2327:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(dbitno + nblocks <= BPERDMAP);
           ^
   fs/jfs/jfs_dmap.c:2612:4: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                           assert(level == bmp->db_maxlevel);
                           ^
   fs/jfs/jfs_dmap.c:2721:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(leaf[leafno] == NOFREE);
           ^
   fs/jfs/jfs_dmap.c:2989:3: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                   assert(n < 4);
                   ^
   fs/jfs/jfs_dmap.c:3025:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(nb <= DBWORD);
           ^
   fs/jfs/jfs_dmap.c:3172:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(0);
           ^
   fs/jfs/jfs_dmap.c:3270:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(dbitno + nblocks <= BPERDMAP);
           ^
   11 errors generated.
--
>> fs/jfs/jfs_dtree.c:775:3: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                   BT_PUSH(btstack, bn, index);
                   ^
   fs/jfs/jfs_btree.h:119:2: note: expanded from macro 'BT_PUSH'
           assert(!BT_STACK_FULL(BTSTACK));\
           ^
   fs/jfs/jfs_dtree.c:3376:3: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                   BT_PUSH(btstack, bn, 0);
                   ^
   fs/jfs/jfs_btree.h:119:2: note: expanded from macro 'BT_PUSH'
           assert(!BT_STACK_FULL(BTSTACK));\
           ^
   2 errors generated.
--
>> fs/jfs/jfs_metapage.c:739:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(mp->count);
           ^
   1 error generated.
--
>> fs/jfs/jfs_logmgr.c:1595:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(list_empty(&log->cqueue));
           ^
   fs/jfs/jfs_logmgr.c:1929:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(bp->l_wqnext == NULL);
           ^
   fs/jfs/jfs_logmgr.c:2312:3: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                   assert(bp->l_flag & lbmRELEASE);
                   ^
   3 errors generated.
--
>> fs/jfs/jfs_txnmgr.c:523:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(tblk->next == 0);
           ^
   fs/jfs/jfs_txnmgr.c:656:5: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                                   assert(last);
                                   ^
   fs/jfs/jfs_txnmgr.c:875:4: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                           assert(mp->xflag & COMMIT_PAGE);
                           ^
   fs/jfs/jfs_txnmgr.c:920:4: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                           assert(mp->xflag & COMMIT_PAGE);
                           ^
   fs/jfs/jfs_txnmgr.c:2241:4: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                           assert(mp->xflag & COMMIT_PAGE);
                           ^
   fs/jfs/jfs_txnmgr.c:2372:4: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                           assert(mp->nohomeok == 1);
                           ^
   fs/jfs/jfs_txnmgr.c:2827:2: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
           assert(mp->nohomeok);
           ^
   7 errors generated.
--
>> fs/jfs/xattr.c:153:3: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                   assert(size <= sizeof (ji->i_inline_ea));
                   ^
   fs/jfs/xattr.c:583:3: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                   assert(ea_buf->mp);
                   ^
   fs/jfs/xattr.c:603:3: error: implicit declaration of function 'assert' [-Werror,-Wimplicit-function-declaration]
                   assert(new_size <= sizeof (ji->i_inline_ea));
                   ^
   3 errors generated.

# https://github.com/0day-ci/linux/commit/073244e1adc3932156c9523a347b3edec3d87a9d
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Chunguang-Xu/clean-up-the-code-related-to-ASSERT/20200827-182148
git checkout 073244e1adc3932156c9523a347b3edec3d87a9d
vim +/assert +524 fs/jfs/namei.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  441  
^1da177e4c3f41 Linus Torvalds    2005-04-16  442  /*
^1da177e4c3f41 Linus Torvalds    2005-04-16  443   * NAME:	jfs_unlink(dip, dentry)
^1da177e4c3f41 Linus Torvalds    2005-04-16  444   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  445   * FUNCTION:	remove a link to object <vp> named by <name>
^1da177e4c3f41 Linus Torvalds    2005-04-16  446   *		from parent directory <dvp>
^1da177e4c3f41 Linus Torvalds    2005-04-16  447   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  448   * PARAMETER:	dip	- inode of parent directory
^1da177e4c3f41 Linus Torvalds    2005-04-16  449   *		dentry	- dentry of object to be removed
^1da177e4c3f41 Linus Torvalds    2005-04-16  450   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  451   * RETURN:	errors from subroutines
^1da177e4c3f41 Linus Torvalds    2005-04-16  452   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  453   * note:
^1da177e4c3f41 Linus Torvalds    2005-04-16  454   * temporary file: if one or more processes have the file open
^1da177e4c3f41 Linus Torvalds    2005-04-16  455   * when the last link is removed, the link will be removed before
^1da177e4c3f41 Linus Torvalds    2005-04-16  456   * unlink() returns, but the removal of the file contents will be
^1da177e4c3f41 Linus Torvalds    2005-04-16  457   * postponed until all references to the files are closed.
^1da177e4c3f41 Linus Torvalds    2005-04-16  458   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  459   * JFS does NOT support unlink() on directories.
^1da177e4c3f41 Linus Torvalds    2005-04-16  460   *
^1da177e4c3f41 Linus Torvalds    2005-04-16  461   */
^1da177e4c3f41 Linus Torvalds    2005-04-16  462  static int jfs_unlink(struct inode *dip, struct dentry *dentry)
^1da177e4c3f41 Linus Torvalds    2005-04-16  463  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  464  	int rc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  465  	tid_t tid;		/* transaction id */
2b0143b5c986be David Howells     2015-03-17  466  	struct inode *ip = d_inode(dentry);
^1da177e4c3f41 Linus Torvalds    2005-04-16  467  	ino_t ino;
^1da177e4c3f41 Linus Torvalds    2005-04-16  468  	struct component_name dname;	/* object name */
^1da177e4c3f41 Linus Torvalds    2005-04-16  469  	struct inode *iplist[2];
^1da177e4c3f41 Linus Torvalds    2005-04-16  470  	struct tblock *tblk;
^1da177e4c3f41 Linus Torvalds    2005-04-16  471  	s64 new_size = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  472  	int commit_flag;
^1da177e4c3f41 Linus Torvalds    2005-04-16  473  
a455589f181e60 Al Viro           2014-10-21  474  	jfs_info("jfs_unlink: dip:0x%p name:%pd", dip, dentry);
^1da177e4c3f41 Linus Torvalds    2005-04-16  475  
^1da177e4c3f41 Linus Torvalds    2005-04-16  476  	/* Init inode for quota operations. */
acc84b05b1f463 Dave Kleikamp     2015-07-15  477  	rc = dquot_initialize(dip);
acc84b05b1f463 Dave Kleikamp     2015-07-15  478  	if (rc)
acc84b05b1f463 Dave Kleikamp     2015-07-15  479  		goto out;
acc84b05b1f463 Dave Kleikamp     2015-07-15  480  	rc = dquot_initialize(ip);
acc84b05b1f463 Dave Kleikamp     2015-07-15  481  	if (rc)
acc84b05b1f463 Dave Kleikamp     2015-07-15  482  		goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  483  
^1da177e4c3f41 Linus Torvalds    2005-04-16  484  	if ((rc = get_UCSname(&dname, dentry)))
^1da177e4c3f41 Linus Torvalds    2005-04-16  485  		goto out;
^1da177e4c3f41 Linus Torvalds    2005-04-16  486  
82d5b9a7c63054 Dave Kleikamp     2007-01-09  487  	IWRITE_LOCK(ip, RDWRLOCK_NORMAL);
^1da177e4c3f41 Linus Torvalds    2005-04-16  488  
^1da177e4c3f41 Linus Torvalds    2005-04-16  489  	tid = txBegin(dip->i_sb, 0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  490  
82d5b9a7c63054 Dave Kleikamp     2007-01-09  491  	mutex_lock_nested(&JFS_IP(dip)->commit_mutex, COMMIT_MUTEX_PARENT);
82d5b9a7c63054 Dave Kleikamp     2007-01-09  492  	mutex_lock_nested(&JFS_IP(ip)->commit_mutex, COMMIT_MUTEX_CHILD);
^1da177e4c3f41 Linus Torvalds    2005-04-16  493  
^1da177e4c3f41 Linus Torvalds    2005-04-16  494  	iplist[0] = dip;
^1da177e4c3f41 Linus Torvalds    2005-04-16  495  	iplist[1] = ip;
^1da177e4c3f41 Linus Torvalds    2005-04-16  496  
^1da177e4c3f41 Linus Torvalds    2005-04-16  497  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  498  	 * delete the entry of target file from parent directory
^1da177e4c3f41 Linus Torvalds    2005-04-16  499  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  500  	ino = ip->i_ino;
^1da177e4c3f41 Linus Torvalds    2005-04-16  501  	if ((rc = dtDelete(tid, dip, &dname, &ino, JFS_REMOVE))) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  502  		jfs_err("jfs_unlink: dtDelete returned %d", rc);
^1da177e4c3f41 Linus Torvalds    2005-04-16  503  		if (rc == -EIO)
^1da177e4c3f41 Linus Torvalds    2005-04-16  504  			txAbort(tid, 1);	/* Marks FS Dirty */
^1da177e4c3f41 Linus Torvalds    2005-04-16  505  		txEnd(tid);
1de87444f8f910 Ingo Molnar       2006-01-24  506  		mutex_unlock(&JFS_IP(ip)->commit_mutex);
48ce8b056c8892 Evgeniy Dushistov 2006-06-05  507  		mutex_unlock(&JFS_IP(dip)->commit_mutex);
^1da177e4c3f41 Linus Torvalds    2005-04-16  508  		IWRITE_UNLOCK(ip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  509  		goto out1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  510  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  511  
^1da177e4c3f41 Linus Torvalds    2005-04-16  512  	ASSERT(ip->i_nlink);
^1da177e4c3f41 Linus Torvalds    2005-04-16  513  
078cd8279e6599 Deepa Dinamani    2016-09-14  514  	ip->i_ctime = dip->i_ctime = dip->i_mtime = current_time(ip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  515  	mark_inode_dirty(dip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  516  
^1da177e4c3f41 Linus Torvalds    2005-04-16  517  	/* update target's inode */
9a53c3a783c2fa Dave Hansen       2006-09-30  518  	inode_dec_link_count(ip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  519  
^1da177e4c3f41 Linus Torvalds    2005-04-16  520  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  521  	 *	commit zero link count object
^1da177e4c3f41 Linus Torvalds    2005-04-16  522  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  523  	if (ip->i_nlink == 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16 @524  		assert(!test_cflag(COMMIT_Nolink, ip));
^1da177e4c3f41 Linus Torvalds    2005-04-16  525  		/* free block resources */
^1da177e4c3f41 Linus Torvalds    2005-04-16  526  		if ((new_size = commitZeroLink(tid, ip)) < 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  527  			txAbort(tid, 1);	/* Marks FS Dirty */
^1da177e4c3f41 Linus Torvalds    2005-04-16  528  			txEnd(tid);
1de87444f8f910 Ingo Molnar       2006-01-24  529  			mutex_unlock(&JFS_IP(ip)->commit_mutex);
48ce8b056c8892 Evgeniy Dushistov 2006-06-05  530  			mutex_unlock(&JFS_IP(dip)->commit_mutex);
^1da177e4c3f41 Linus Torvalds    2005-04-16  531  			IWRITE_UNLOCK(ip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  532  			rc = new_size;
^1da177e4c3f41 Linus Torvalds    2005-04-16  533  			goto out1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  534  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  535  		tblk = tid_to_tblock(tid);
^1da177e4c3f41 Linus Torvalds    2005-04-16  536  		tblk->xflag |= COMMIT_DELETE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  537  		tblk->u.ip = ip;
^1da177e4c3f41 Linus Torvalds    2005-04-16  538  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  539  
^1da177e4c3f41 Linus Torvalds    2005-04-16  540  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  541  	 * Incomplete truncate of file data can
^1da177e4c3f41 Linus Torvalds    2005-04-16  542  	 * result in timing problems unless we synchronously commit the
^1da177e4c3f41 Linus Torvalds    2005-04-16  543  	 * transaction.
^1da177e4c3f41 Linus Torvalds    2005-04-16  544  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  545  	if (new_size)
^1da177e4c3f41 Linus Torvalds    2005-04-16  546  		commit_flag = COMMIT_SYNC;
^1da177e4c3f41 Linus Torvalds    2005-04-16  547  	else
^1da177e4c3f41 Linus Torvalds    2005-04-16  548  		commit_flag = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  549  
^1da177e4c3f41 Linus Torvalds    2005-04-16  550  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  551  	 * If xtTruncate was incomplete, commit synchronously to avoid
^1da177e4c3f41 Linus Torvalds    2005-04-16  552  	 * timing complications
^1da177e4c3f41 Linus Torvalds    2005-04-16  553  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  554  	rc = txCommit(tid, 2, &iplist[0], commit_flag);
^1da177e4c3f41 Linus Torvalds    2005-04-16  555  
^1da177e4c3f41 Linus Torvalds    2005-04-16  556  	txEnd(tid);
^1da177e4c3f41 Linus Torvalds    2005-04-16  557  
1de87444f8f910 Ingo Molnar       2006-01-24  558  	mutex_unlock(&JFS_IP(ip)->commit_mutex);
48ce8b056c8892 Evgeniy Dushistov 2006-06-05  559  	mutex_unlock(&JFS_IP(dip)->commit_mutex);
^1da177e4c3f41 Linus Torvalds    2005-04-16  560  
^1da177e4c3f41 Linus Torvalds    2005-04-16  561  	while (new_size && (rc == 0)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  562  		tid = txBegin(dip->i_sb, 0);
1de87444f8f910 Ingo Molnar       2006-01-24  563  		mutex_lock(&JFS_IP(ip)->commit_mutex);
^1da177e4c3f41 Linus Torvalds    2005-04-16  564  		new_size = xtTruncate_pmap(tid, ip, new_size);
^1da177e4c3f41 Linus Torvalds    2005-04-16  565  		if (new_size < 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  566  			txAbort(tid, 1);	/* Marks FS Dirty */
^1da177e4c3f41 Linus Torvalds    2005-04-16  567  			rc = new_size;
^1da177e4c3f41 Linus Torvalds    2005-04-16  568  		} else
^1da177e4c3f41 Linus Torvalds    2005-04-16  569  			rc = txCommit(tid, 2, &iplist[0], COMMIT_SYNC);
^1da177e4c3f41 Linus Torvalds    2005-04-16  570  		txEnd(tid);
1de87444f8f910 Ingo Molnar       2006-01-24  571  		mutex_unlock(&JFS_IP(ip)->commit_mutex);
^1da177e4c3f41 Linus Torvalds    2005-04-16  572  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  573  
^1da177e4c3f41 Linus Torvalds    2005-04-16  574  	if (ip->i_nlink == 0)
^1da177e4c3f41 Linus Torvalds    2005-04-16  575  		set_cflag(COMMIT_Nolink, ip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  576  
^1da177e4c3f41 Linus Torvalds    2005-04-16  577  	IWRITE_UNLOCK(ip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  578  
^1da177e4c3f41 Linus Torvalds    2005-04-16  579  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  580  	 * Truncating the directory index table is not guaranteed.  It
^1da177e4c3f41 Linus Torvalds    2005-04-16  581  	 * may need to be done iteratively
^1da177e4c3f41 Linus Torvalds    2005-04-16  582  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  583  	if (test_cflag(COMMIT_Stale, dip)) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  584  		if (dip->i_size > 1)
^1da177e4c3f41 Linus Torvalds    2005-04-16  585  			jfs_truncate_nolock(dip, 0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  586  
^1da177e4c3f41 Linus Torvalds    2005-04-16  587  		clear_cflag(COMMIT_Stale, dip);
^1da177e4c3f41 Linus Torvalds    2005-04-16  588  	}
^1da177e4c3f41 Linus Torvalds    2005-04-16  589  
^1da177e4c3f41 Linus Torvalds    2005-04-16  590        out1:
^1da177e4c3f41 Linus Torvalds    2005-04-16  591  	free_UCSname(&dname);
^1da177e4c3f41 Linus Torvalds    2005-04-16  592        out:
^1da177e4c3f41 Linus Torvalds    2005-04-16  593  	jfs_info("jfs_unlink: rc:%d", rc);
^1da177e4c3f41 Linus Torvalds    2005-04-16  594  	return rc;
^1da177e4c3f41 Linus Torvalds    2005-04-16  595  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  596  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--YiEDa0DAkWCtVeE4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
nSoi7bU2M5qYX19OyLG8RP4/DIG1gM3wAQA=

--YiEDa0DAkWCtVeE4--
